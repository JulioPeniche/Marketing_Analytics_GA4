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



-- ==========================================
-- Estrutura geral dos eventos
-- ==========================================

SELECT
  event_date,
  event_timestamp,
  event_name,
  user_pseudo_id,
  platform,
  device.category,
  device.operating_system,
  geo.country,
  traffic_source.source,
  traffic_source.medium
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 10;



-- ==========================================
-- Parâmetros disponíveis nos eventos
-- ==========================================

SELECT
  ep.key AS parametro,
  COUNT(*) AS ocorrencias
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(event_params) AS ep
GROUP BY
  parametro
ORDER BY
  ocorrencias DESC;



-- ==========================================
-- Estrutura dos produtos (items)
-- ==========================================

SELECT
  event_name,
  item.item_id,
  item.item_name,
  item.item_brand,
  item.item_category,
  item.price,
  item.quantity
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS item
LIMIT 20;

