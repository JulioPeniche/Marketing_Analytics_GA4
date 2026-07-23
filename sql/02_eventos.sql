-- =====================================================
-- 02_eventos.sql
-- Análise de Eventos
-- Google Merchandise Store (GA4)
-- =====================================================

WITH eventos AS (

  SELECT
    event_name,
    COUNT(*) AS total_eventos,
    COUNT(DISTINCT user_pseudo_id) AS usuarios_unicos

  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

  GROUP BY
    event_name

),

total AS (

  SELECT
    SUM(total_eventos) AS total_geral
  FROM
    eventos

)

SELECT

  e.event_name,

  e.total_eventos,

  e.usuarios_unicos,

  ROUND(
    SAFE_DIVIDE(e.total_eventos, t.total_geral) * 100,
    2
  ) AS percentual_eventos

FROM
  eventos e
CROSS JOIN
  total t

ORDER BY
  total_eventos DESC;
