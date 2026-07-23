
-- Usuários únicos

SELECT
  COUNT(DISTINCT user_pseudo_id) AS usuarios_unicos
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;



-- Total de sessões

SELECT
  COUNT(DISTINCT CONCAT(
      user_pseudo_id,
      CAST((
        SELECT value.int_value
        FROM UNNEST(event_params)
        WHERE key = 'ga_session_id'
      ) AS STRING)
  )) AS total_sessoes

FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;



-- Usuários por dia

SELECT

PARSE_DATE('%Y%m%d', event_date) AS data,

COUNT(DISTINCT user_pseudo_id) AS usuarios

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

GROUP BY data

ORDER BY data;



---Sessões por dia

SELECT

PARSE_DATE('%Y%m%d', event_date) AS data,

COUNT(DISTINCT CONCAT(
user_pseudo_id,

CAST((
SELECT value.int_value
FROM UNNEST(event_params)
WHERE key='ga_session_id'
) AS STRING)

)) AS sessoes

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

GROUP BY data

ORDER BY data;
