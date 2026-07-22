-- ==========================================
-- Exploração inicial do Dataset GA4
-- Projeto: Marketing Analytics 02
-- Fonte: Google Merchandise Store (GA4)
-- ==========================================

-- Total de registros
SELECT
  COUNT(*) AS total_registros
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;

-- Período disponível
SELECT
  MIN(PARSE_DATE('%Y%m%d', event_date)) AS primeira_data,
  MAX(PARSE_DATE('%Y%m%d', event_date)) AS ultima_data
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;



-- ==========================================
-- Eventos disponíveis
-- ==========================================

SELECT
  event_name,
  COUNT(*) AS total_eventos
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY
  event_name
ORDER BY
  total_eventos DESC;

-- Total de usuários
SELECT
  COUNT(DISTINCT user_pseudo_id) AS usuarios
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
