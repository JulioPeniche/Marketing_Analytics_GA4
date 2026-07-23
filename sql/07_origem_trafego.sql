-- 07_origem_trafego.sql
-- Origem e tráfego GA4

SELECT

  traffic_source.source AS origem,

  traffic_source.medium AS midia,

  COUNT(DISTINCT user_pseudo_id) AS usuarios,

  COUNT(
    DISTINCT CONCAT(
      user_pseudo_id,
      CAST(ga_session_id AS STRING)
    )
  ) AS sessoes,

  COUNTIF(event_name = 'purchase') AS compras,

  SUM(
    ecommerce.purchase_revenue
  ) AS receita,

  SAFE_DIVIDE(
    COUNTIF(event_name = 'purchase'),
    COUNT(
      DISTINCT CONCAT(
        user_pseudo_id,
        CAST(ga_session_id AS STRING)
      )
    )
  ) AS taxa_conversao


FROM (

  SELECT

    *,

    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
    ) AS ga_session_id

  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

)

GROUP BY

  origem,
  midia


ORDER BY

  receita DESC;
