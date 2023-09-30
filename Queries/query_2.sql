CREATE OR REPLACE TABLE keepcoding.ivr_sumary AS

WITH grupos AS (SELECT
    det.calls_ivr_id AS ivr_id
  , det.calls_phone_number AS phone_number
  , det.calls_ivr_result AS ivr_result
  , det.calls_start_date AS start_date
  , det.calls_end_date AS end_date
  , det.calls_total_duration AS total_duration
  , det.calls_customer_segment AS customer_segment
  , det.calls_ivr_language AS ivr_language
  , det.calls_steps_module AS steps_module
  , det.calls_module_aggregation AS module_aggregation
  , LAG(det.calls_start_date) OVER (PARTITION BY det.calls_phone_number ORDER BY det.calls_phone_number, det.calls_start_date) AS anterior
  , LEAD(det.calls_start_date) OVER (PARTITION BY det.calls_phone_number ORDER BY det.calls_phone_number, det.calls_start_date) AS posterior
  FROM keepcoding.ivr_detail det
  GROUP BY ivr_id, phone_number, ivr_result, start_date, end_date, total_duration, customer_segment, ivr_language, steps_module, module_aggregation
  ORDER BY det.calls_phone_number
),
filtrado AS (SELECT
    det.calls_ivr_id
  , NULLIF(det.document_type, 'NULL') AS document_type
  , NULLIF(det.document_identification, 'NULL') AS document_identification
  , NULLIF(det.customer_phone, 'NULL') AS customer_phone
  , NULLIF(det.billing_account_id, 'NULL') AS billing_account_id
FROM keepcoding.ivr_detail det
LEFT
  JOIN keepcoding.ivr_steps steps
  ON steps.ivr_id = det.calls_ivr_id
GROUP BY
    calls_ivr_id
  , document_type
  , document_identification
  , customer_phone
  , billing_account_id
QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(det.calls_ivr_id AS STRING)
        ORDER BY det.calls_ivr_id, document_type DESC, document_identification DESC, customer_phone DESC, billing_account_id DESC) = 1
)

SELECT
    grupos.ivr_id
  , grupos.phone_number
  , grupos.ivr_result
  , CASE WHEN STARTS_WITH(det.calls_vdn_label, 'ATC') THEN 'FRONT'
         WHEN STARTS_WITH(det.calls_vdn_label, 'TECH') THEN 'TECH'
         WHEN det.calls_vdn_label = 'ABSORPTION' THEN det.calls_vdn_label
         ELSE 'FRONT'
         END AS vdn_aggregation
  , grupos.start_date
  , grupos.end_date
  , grupos.total_duration
  , grupos.customer_segment
  , grupos.ivr_language
  , grupos.steps_module
  , grupos.module_aggregation
  , filtrado.document_type
  , filtrado.document_identification
  , filtrado.customer_phone
  , filtrado.billing_account_id
  , IF(CONTAINS_SUBSTR(det.calls_module_aggregation, 'AVERIA_MASIVA'), 1, 0) AS masiva_lg
  , CASE WHEN SUM(IF((det.step_name = 'CUSTOMERINFOBYPHONE.TX') AND (det.step_description_error = 'NULL' ), 1, 0)) > 0 THEN 1 ELSE 0 END AS info_by_phone_lg
  , CASE WHEN SUM(IF((det.step_name = 'CUSTOMERINFOBYDNI.TX') AND (det.step_description_error = 'NULL' ), 1, 0)) > 0 THEN 1 ELSE 0 END AS info_by_dni_lg
  , IF(DATETIME_DIFF(det.calls_start_date, grupos.anterior, HOUR) < 24,1,0) AS repeated_phone_24H
  , IF(DATETIME_DIFF(grupos.posterior,det.calls_end_date, HOUR) < 24,1,0) AS cause_recall_phone_24H

FROM filtrado
LEFT JOIN grupos
ON filtrado.calls_ivr_id = grupos.ivr_id
LEFT JOIN keepcoding.ivr_detail det
ON grupos.ivr_id = det.calls_ivr_id
GROUP BY
    grupos.ivr_id
  , grupos.phone_number
  , grupos.ivr_result
  , vdn_aggregation
  , grupos.start_date
  , grupos.end_date
  , grupos.total_duration
  , grupos.customer_segment
  , grupos.ivr_language
  , grupos.steps_module
  , grupos.module_aggregation
  , document_type
  , document_identification
  , customer_phone
  , billing_account_id
  , masiva_lg
  , repeated_phone_24H
  , cause_recall_phone_24H
ORDER BY grupos.phone_number, grupos.ivr_id;
