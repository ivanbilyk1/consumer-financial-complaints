CREATE TABLE IF NOT EXISTS "complaints_raw" (
    "data_received" DATA NOT NULL,
    "product" TEXT NOT NULL,
    "sub_product" TEXT,
    "issue" TEXT NOT NULL,
    "sub_issue" TEXT,
    "consumer_complaint_narrative" TEXT,
    "company_public_response" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip_code" INTEGER NOT NULL,
    "tags" TEXT NOT NULL,
    "consumer_consent_provided" TEXT NOT NULL,
    "submitted_via" TEXT,
    "date_sent_to_company" DATA NOT NULL,
    "company_response_to_consumer" TEXT NOT NULL,
    "timely_response" TEXT NOT NULL  CHECK ("timely_response" IN ('Yes', 'No')),
    "consumer_disputed" TEXT,
    "complaint_id" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "complaints" (
    "id" INTEGER NOT NULL,
    "date_received" DATA NOT NULL,
    "company_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "subproduct_id" INTEGER,
    "issue_id" INTEGER NOT NULL,
    "subissue_id" INTEGER,
    "location_id" INTEGER NOT NULL,
    "submission_channel_id" INTEGER NOT NULL,
    "date_sent_to_company" DATA NOT NULL,
    "consumer_narrative" TEXT NOT NULL,
    "consumer_consent_provided" TEXT NOT NULL,
    "timely_response" TEXT  CHECK ("timely_response" IN ('TRUE', 'FALSE', 'NULL')),
    "consumer_disputed" TEXT  CHECK ("consumer_disputed" IN ('TRUE', 'FALSE', 'NULL')),
    PRIMARY KEY("id"),
    FOREIGN KEY ("product_id") REFERENCES "product"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id"),
    FOREIGN KEY ("subproduct_id") REFERENCES "subproducts"("id"),
    FOREIGN KEY ("subissue_id") REFERENCES "subissues"("id"),
    FOREIGN KEY ("issue_id") REFERENCES "issues"("id"),
    FOREIGN KEY ("location_id") REFERENCES "locations"("id"),
    FOREIGN KEY ("submission_channels_id") REFERENCES "submission_channels"("id")
);

CREATE TABLE IF NOT EXISTS "companies" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "products" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "subproducts" (
    "id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("product_id") REFERENCES "product"("id")
);

CREATE TABLE IF NOT EXISTS "issues" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "subissues" (
    "id" INTEGER NOT NULL,
    "issue_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("issue_id") REFERENCES "issues"("id")
);

CREATE TABLE IF NOT EXISTS "locations" (
    "id" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "zip_code" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "submission_channels" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "response_types" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "complaint_responses" (
    "id" INTEGER NOT NULL,
    "complaint_id" INTEGER NOT NULL,
    "response_type_id" INTEGER NOT NULL,
    "public_response" TEXT,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY ("response_type_id") REFERENCES "complaints"("id"),
    FOREIGN KEY ("response_type_id") REFERENCES "response_types"("id")
);

CREATE TABLE IF NOT EXISTS "tags" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "complaint_tags" (
    "complaint_id" INTEGER NOT NULL,
    "tag_id" INTEGER NOT NULL,
    FOREIGN KEY ("complaint_id") REFERENCES "complaints"("id"),
    FOREIGN KEY ("tag_id") REFERENCES "tags"("id")
);

