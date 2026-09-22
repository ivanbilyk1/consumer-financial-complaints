INSERT INTO "companies"("name")
SELECT DISTINCT "company" FROM "complaints_raw" 
WHERE NULLIF("company", '') IS NOT NULL;

INSERT INTO "products"("name")
SELECT DISTINCT "product" FROM "complaints_raw" 
WHERE NULLIF("product", '') IS NOT NULL;

INSERT INTO "subproducts"("product_id", "name")
SELECT DISTINCT "products"."id", "complaints_raw"."sub_product" FROM "complaints_raw" 
JOIN "products" ON "products"."name" = "complaints_raw"."product"
WHERE NULLIF("complaints_raw"."sub_product", '') IS NOT NULL;

INSERT INTO "issues" ("name")
SELECT DISTINCT
    TRIM("issue")
FROM "complaints_raw"
WHERE NULLIF(TRIM("issue"), '') IS NOT NULL;

INSERT INTO "subissues"("issue_id", "name")
SELECT DISTINCT "issues"."id", "complaints_raw"."sub_issue" FROM "complaints_raw" 
JOIN "issues" ON "issues"."name" = "complaints_raw"."issue"
WHERE NULLIF("complaints_raw"."sub_issue", '') IS NOT NULL;

INSERT INTO "locations" ("state", "zip_code")
SELECT DISTINCT
    TRIM("state"),
    NULLIF(TRIM("zip_code"), '')
FROM "complaints_raw"
WHERE NULLIF(TRIM("state"), '') IS NOT NULL;

INSERT INTO "submission_channels"("name")
SELECT DISTINCT "submitted_via" FROM "complaints_raw"
WHERE NULLIF("submitted_via", '') IS NOT NULL;

INSERT INTO "response_types"("name")
SELECT DISTINCT "company_response_to_consumer" FROM "complaints_raw"
WHERE NULLIF("company_response_to_consumer", '') IS NOT NULL;

INSERT INTO "tags"("name")
SELECT DISTINCT "tags" FROM "complaints_raw"
WHERE NULLIF("tags", '') IS NOT NULL;

INSERT INTO "complaints" (
    "id",
    "date_received",
    "company_id",
    "product_id",
    "subproduct_id",
    "issue_id",
    "subissue_id",
    "location_id",
    "submission_channel_id",
    "date_sent_to_company",
    "timely_response"
)
SELECT
    CAST(r."complaint_id" AS INTEGER),
    TRIM(r."date_received"),
    c."id",
    p."id",
    sp."id",
    i."id",
    si."id",
    l."id",
    sc."id",
    NULLIF(TRIM(r."date_sent_to_company"), ''),
    CASE LOWER(TRIM(r."timely_response"))
        WHEN 'yes' THEN 1
        WHEN 'no' THEN 0
        ELSE NULL
    END
FROM "complaints_raw" AS r

JOIN "companies" AS c
    ON c."name" = r."company"

JOIN "products" AS p
    ON p."name" = r."product"

LEFT JOIN "subproducts" AS sp
    ON sp."product_id" = p."id"
    AND sp."name" = NULLIF(TRIM(r."sub_product"), '')

JOIN "issues" AS i
    ON i."name" = r."issue"

LEFT JOIN "subissues" AS si
    ON si."issue_id" = i."id"
    AND si."name" = NULLIF(TRIM(r."sub_issue"), '')

LEFT JOIN "locations" AS l
    ON l."state" = r."state"
    AND l."zip_code" = r."zip_code"

JOIN "submission_channels" AS sc
    ON sc."name" = r."submitted_via"

WHERE NULLIF(TRIM(r."complaint_id"), '') IS NOT NULL
  AND NULLIF(TRIM(r."date_received"), '') IS NOT NULL;

INSERT INTO "complaint_responses"("complaint_id", "response_type_id", "public_response")
SELECT DISTINCT "complaints"."id", "response_types"."id", "complaints_raw"."company_public_response" FROM "complaints_raw"
JOIN "response_types" ON "response_types"."name" = "complaints_raw"."company_response_to_consumer"
JOIN "complaints" ON "complaints"."id" = "complaints_raw"."complaint_id";


INSERT INTO "complaint_tags"("complaint_id", "tag_id")
SELECT DISTINCT "complaints"."id", "tags"."id" FROM "complaints_raw"
JOIN "tags" ON "tags"."name" = "complaints_raw"."tags"
JOIN "complaints" ON "complaints"."id" = "complaints_raw"."complaint_id";