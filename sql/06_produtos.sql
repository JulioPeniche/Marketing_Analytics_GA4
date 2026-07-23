

-- Top 10 produtos por receita

SELECT

items.item_name,

ROUND(
SUM(items.price * items.quantity),
2
) AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,

UNNEST(items) AS items

WHERE
event_name = 'purchase'

GROUP BY
items.item_name

ORDER BY
receita DESC

LIMIT 10;



-- Top 10 produtos por quantidade vendida

SELECT

items.item_name,

SUM(items.quantity) AS quantidade_vendida

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,

UNNEST(items) AS items

WHERE
event_name = 'purchase'

GROUP BY
items.item_name

ORDER BY
quantidade_vendida DESC

LIMIT 10;



-- Top 10 categorias por receita

SELECT

items.item_category,

ROUND(
SUM(items.price * items.quantity),
2
) AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,

UNNEST(items) AS items

WHERE
event_name = 'purchase'

GROUP BY
items.item_category

ORDER BY
receita DESC

LIMIT 10;



-- Top 10 categorias por quantidade vendida

SELECT

items.item_category,

SUM(items.quantity) AS quantidade_vendida

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS items

WHERE
event_name = 'purchase'

GROUP BY
items.item_category

ORDER BY
quantidade_vendida DESC

LIMIT 10;
