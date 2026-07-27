CREATE OR REPLACE TABLE
`marketing-analytics-ga4-503017.ga4_analytics.dashboard` AS

WITH eventos AS (

SELECT

    PARSE_DATE('%Y%m%d', event_date) AS data,

    device.category AS dispositivo,

    geo.country AS pais,

    traffic_source.source AS origem,

    traffic_source.medium AS midia,

    user_pseudo_id,

    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
    ) AS ga_session_id,

    event_name,

    ecommerce.purchase_revenue AS receita

FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

)

SELECT

    data,

    dispositivo,

    pais,

    COALESCE(origem,'(direct)') AS origem,

    COALESCE(midia,'(none)') AS midia,

    COUNT(DISTINCT user_pseudo_id) AS usuarios,

    COUNT(DISTINCT CONCAT(user_pseudo_id,'-',CAST(ga_session_id AS STRING))) AS sessoes,

    COUNTIF(event_name='purchase') AS compras,

    ROUND(SUM(IFNULL(receita,0)),2) AS receita

FROM eventos

GROUP BY
    data,
    dispositivo,
    pais,
    origem,
    midia

ORDER BY
    data;
