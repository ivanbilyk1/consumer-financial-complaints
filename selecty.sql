#компанії з найбільшою кількістю скарг
SELECT "companies"."name", COUNT(*) AS "count" FROM "complaints"
JOIN "companies" ON "companies"."id" = "complaints"."company_id"
GROUP BY "companies"."id", "companies"."name"
ORDER BY "count" DESC
LIMIT 10;

#за місяцями
SELECT
    strftime('%Y-%m', "date_received") AS "month",
    COUNT(*) AS "complaints_count"
FROM "complaints"
GROUP BY "month"
ORDER BY "month";