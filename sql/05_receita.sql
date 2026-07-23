
-- Receita diária

SELECT

PARSE_DATE('%Y%m%d', event_date) AS data,

ROUND(
SUM(ecommerce.purchase_revenue),
2
) AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
event_name = 'purchase'

GROUP BY
data

ORDER BY
data;



-- Receita por mês

SELECT

FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', event_date)) AS mes,

ROUND(
SUM(ecommerce.purchase_revenue),
2
) AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
event_name = 'purchase'

GROUP BY
mes

ORDER BY
mes;



-- Ticket médio

SELECT

ROUND(
AVG(ecommerce.purchase_revenue),
2
) AS ticket_medio

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
event_name = 'purchase'
AND ecommerce.purchase_revenue IS NOT NULL;



-- Receita por dia da semana

SELECT

FORMAT_DATE('%A', PARSE_DATE('%Y%m%d', event_date)) AS dia_semana,

ROUND(
SUM(ecommerce.purchase_revenue),
2
) AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
event_name = 'purchase'

GROUP BY
dia_semana

ORDER BY
receita DESC;
