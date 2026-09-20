DROP TABLE IF EXISTS "complaints_raw";
DROP TABLE IF EXISTS "complaints";
DROP TABLE IF EXISTS "companies";
DROP TABLE IF EXISTS "products";
DROP TABLE IF EXISTS "subproducts";
DROP TABLE IF EXISTS "issues";
DROP TABLE IF EXISTS "subissues";
DROP TABLE IF EXISTS "locations";
DROP TABLE IF EXISTS "submission_channels";
DROP TABLE IF EXISTS "response_types";
DROP TABLE IF EXISTS "complaint_responses";
DROP TABLE IF EXISTS "tags";
DROP TABLE IF EXISTS "complaint_tags";

CREATE TABLE IF NOT EXISTS "complaints_raw" (
    "date_received" TEXT,
    "product" TEXT,
    "sub_product" TEXT,
    "issue" TEXT,
    "sub_issue" TEXT,
    "company_public_response" TEXT,
    "company" TEXT,
    "state" TEXT,
    "zip_code" TEXT,
    "tags" TEXT,
    "submitted_via" TEXT,
    "date_sent_to_company" TEXT,
    "company_response_to_consumer" TEXT,
    "timely_response" TEXT,
    "complaint_id" INTEGER
);

CREATE TABLE IF NOT EXISTS "complaints" (
    "id" INTEGER NOT NULL,
    "date_received" TEXT  NOT NULL,
    "company_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "subproduct_id" INTEGER,
    "issue_id" INTEGER NOT NULL,
    "subissue_id" INTEGER,
    "location_id" INTEGER,
    "submission_channel_id" INTEGER NOT NULL,
    "date_sent_to_company" TEXT,
"timely_response" INTEGER
    CHECK ("timely_response" IN (0, 1)),
    PRIMARY KEY("id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id"),
    FOREIGN KEY ("subproduct_id") REFERENCES "subproducts"("id"),
    FOREIGN KEY ("subissue_id") REFERENCES "subissues"("id"),
    FOREIGN KEY ("issue_id") REFERENCES "issues"("id"),
    FOREIGN KEY ("location_id") REFERENCES "locations"("id"),
    FOREIGN KEY ("submission_channel_id") REFERENCES "submission_channels"("id")
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
    FOREIGN KEY ("product_id") REFERENCES "products"("id")
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
    "zip_code" TEXT,
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
    PRIMARY KEY("id"),
    FOREIGN KEY ("complaint_id") REFERENCES "complaints"("id"),
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

