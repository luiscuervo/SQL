/** Note: these Dashboards were ran within the Ninja dashboards tool that is why no ";" are used **/


/******************** DASHBORDS *********************/

/*** See which salesmen have done their first sale in the last month ***/

SELECT *
FROM (
   SELECT 
      RP.name AS "RP name", RP.sp_active_since AS "Active since", rp.email, 
      RP2.name AS Sponsor, RP3.name AS Group, min(CAST(SO.date_order AS date)) as first_order
   FROM 
      res_partner RP 
   LEFT JOIN sale_order SO ON RP.id=SO.partner_type_id 
   LEFT JOIN res_partner RP2 ON RP.sp_sponsor=RP2.id 
   LEFT JOIN res_partner RP3 ON RP.sp_group=RP3.id
   WHERE 
      RP.partner_types='sales partner' AND RP.is_sp_active IS True AND SO.state='sale'
   GROUP BY 
      RP.name, RP.sp_active_since, RP.email, RP2.name, RP3.name
) AS z

WHERE z.first_order > CURRENT_DATE - interval '1 month'

-------------------------------------------------------------------------------------------------------

/*** See which Tecnician has installed each sale order ***/

SELECT 
   RP2.name AS technician, RP1.name as customer, RP1.customer_number, RP1.street, RP1.city, SO.name AS ORDER
FROM sale_order SO
   INNER JOIN res_partner RP1 ON SO.partner_id=RP1.id
   INNER JOIN res_partner RP2 ON SO.technician_id=RP2.id

WHERE SO.state='sale'

--SELECT HERE DATE INTERVAL
-- Option 1 On the previous month
AND SO.date_order > CURRENT_DATE - interval '1 month'

-- Option 2: Between dates
--AND SO.date_order BETWEEN '2008-11-11' AND '2022-11-11'

-------------------------------------------------------------------------------------------------------

/*** Which installations require a filter change in the next month ***/

SELECT RP.name AS client, SO.name AS order, SO.installation_date, next_exchange_date 
FROM sale_order_line SOL
   INNER JOIN sale_order SO ON order_id=SO.id
      AND SO.state='sale'
   LEFT JOIN res_partner RP on SO.partner_id=RP.id
   INNER JOIN product_product PRP on SOL.product_id=PRP.id
      AND PRP.is_exchange_product IS True

--SELECT HERE DATE INTERVAL
WHERE next_exchange_date BETWEEN CURRENT_DATE AND CURRENT_DATE + interval '1 month'

-------------------------------------------------------------------------------------------------------

/*** Number of applications in each recruting stage ***/

SELECT job_name,
  SUM(count_applications)  
        FILTER (WHERE stage LIKE '%Initial%') AS Intial,
  SUM(count_applications) 
        FILTER (WHERE stage LIKE '%Challenge%' OR stage LIKE '%Case%')
        AS Case_Challenge,
  SUM(count_applications) 
        FILTER (WHERE stage LIKE '%First%')
        AS first,
  SUM(count_applications) 
        FILTER (WHERE stage LIKE '%Second%')
        AS second,
  SUM(count_applications) 
        FILTER (WHERE stage LIKE '%Proposal%')
        AS Proposal,
SUM(count_applications) as total
FROM (

	SELECT hj.name as job_name, hrs.name stage, COUNT(ha.id) as count_applications
FROM hr_applicant ha
INNER JOIN hr_job hj ON (ha.job_id = hj.id)
INNER JOIN hr_recruitment_stage hrs on hrs.id = ha.stage_id
WHERE ha.active IS TRUE 
 AND hrs.name NOT LIKE '%Refused%' 
 AND hrs.name NOT LIKE '%To Refuse%' 
 AND hrs.name NOT LIKE '%Contract Signed%' 
 AND hrs.name NOT LIKE '%Pool%' 
GROUP BY hj.name, hrs.name
) as a

GROUP BY job_name
ORDER BY total DESC;
