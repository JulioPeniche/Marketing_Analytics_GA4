
-- Usuários únicos

SELECT
  COUNT(DISTINCT user_pseudo_id) AS usuarios_unicos
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;
