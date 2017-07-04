WITH lmy AS (SELECT
               province.*,
               city.id AS city_id,
               city
             FROM province
               LEFT JOIN city ON city.province_id = province.id),
    yml AS ( SELECT
               lmy.province,
               lmy.city,
               county.county
             FROM lmy
               LEFT JOIN county ON lmy.city_id = county.city_id),
    xxx AS ( SELECT
               province,
               city,
               array_agg(
                   county) AS x
             FROM
               yml
             GROUP BY
               province,
               city) SELECT
                       province,
                       json_object_agg(
                           city,
                           x)
                     FROM
                       xxx
                     GROUP BY
                       province
                     ORDER BY
                       province
