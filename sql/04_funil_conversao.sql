
-- Eventos do funil de conversão

SELECT

event_name,

COUNT(*) AS total_eventos

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
event_name IN (

'view_item',
'add_to_cart',
'begin_checkout',
'purchase'

)

GROUP BY
event_name

ORDER BY
total_eventos DESC;



-- Taxa de conversão do funil

WITH funnel AS (

SELECT

event_name,

COUNT(*) AS total_eventos

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE event_name IN (
'view_item',
'add_to_cart',
'begin_checkout',
'purchase'
)

GROUP BY event_name

)

SELECT

event_name,

total_eventos,

ROUND(
100 * total_eventos /
MAX(CASE WHEN event_name = 'view_item' THEN total_eventos END) OVER (),
2
) AS conversao_desde_view_item

FROM funnel

ORDER BY

CASE event_name
WHEN 'view_item' THEN 1
WHEN 'add_to_cart' THEN 2
WHEN 'begin_checkout' THEN 3
WHEN 'purchase' THEN 4
END;



-- Usuários únicos por etapa do funil

SELECT

event_name,

COUNT(DISTINCT user_pseudo_id) AS usuarios

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE event_name IN (

'view_item',
'add_to_cart',
'begin_checkout',
'purchase'

)

GROUP BY
event_name

ORDER BY

CASE event_name
WHEN 'view_item' THEN 1
WHEN 'add_to_cart' THEN 2
WHEN 'begin_checkout' THEN 3
WHEN 'purchase' THEN 4
END;


