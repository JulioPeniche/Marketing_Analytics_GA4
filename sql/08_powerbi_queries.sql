
-- =====================================================
-- 08_produtos_performance.sql
-- Performance de Produtos
-- Google Merchandise Store (GA4)
-- =====================================================

SELECT
  item.item_name,
  item.item_brand,
  item.item_category,

  COUNT(DISTINCT ecommerce.transaction_id) AS total_compras,

  SUM(item.quantity) AS quantidade_vendida,

  ROUND(
    SUM(item.price * item.quantity),
    2
  ) AS receita_total,

  ROUND(
    AVG(item.price),
    2
  ) AS preco_medio

FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS item

WHERE
  event_name = 'purchase'

GROUP BY
  item.item_name,
  item.item_brand,
  item.item_category

ORDER BY
  receita_total DESC;


