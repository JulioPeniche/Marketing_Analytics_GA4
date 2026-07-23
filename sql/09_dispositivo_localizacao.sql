-- =====================================================
-- 09_dispositivo_localizacao.sql
-- Dispositivos e Localização
-- Google Merchandise Store (GA4)
-- =====================================================

SELECT
  device.category AS dispositivo,

  geo.country AS pais,

  COUNT(DISTINCT user_pseudo_id) AS usuarios,

  COUNT(
    DISTINCT CONCAT(
      user_pseudo_id,
      (
        SELECT ep.value.int_value
        FROM UNNEST(event_params) ep
        WHERE ep.key = 'ga_session_id'
      )
    )
  ) AS sessoes,

  COUNTIF(event_name = 'purchase') AS compras,

  ROUND(
    SUM(
      IF(
        event_name = 'purchase',
        ecommerce.purchase_revenue,
        0
      )
    ),
    2
  ) AS receita

FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

GROUP BY
  dispositivo,
  pais

ORDER BY
  receita DESC;
