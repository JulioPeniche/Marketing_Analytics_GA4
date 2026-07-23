
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



-- Novos usuários por dia

SELECT

  PARSE_DATE('%Y%m%d', event_date) AS data,

  COUNT(DISTINCT user_pseudo_id) AS novos_usuarios

FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
  event_name = 'first_visit'

GROUP BY data

ORDER BY data;



-- Média de eventos por sessão

SELECT

ROUND(
    COUNT(*) /
    COUNT(DISTINCT CONCAT(
        user_pseudo_id,
        CAST((
            SELECT value.int_value
            FROM UNNEST(event_params)
            WHERE key = 'ga_session_id'
        ) AS STRING)
    )),
2
) AS media_eventos_por_sessao

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
(
SELECT value.int_value
FROM UNNEST(event_params)
WHERE key = 'ga_session_id'
) IS NOT NULL;
