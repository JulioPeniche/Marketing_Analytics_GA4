/*
=====================================================
Projeto: Marketing Analytics GA4
Arquivo: 10_kpi_dashboard.sql

Objetivo:
Criar uma tabela contendo os KPIs gerais do projeto,
evitando duplicidade de usuários.
=====================================================
*/

CREATE OR REPLACE TABLE
`marketing-analytics-ga4-503017.ga4_analytics.kpi_dashboard` AS

WITH eventos AS (

SELECT

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

COUNT(DISTINCT user_pseudo_id) AS usuarios,

COUNT(DISTINCT CONCAT(user_pseudo_id,'-',CAST(ga_session_id AS STRING))) AS sessoes,

COUNTIF(event_name = 'purchase') AS compras,

ROUND(SUM(IFNULL(receita,0)),2) AS receita

FROM eventos;