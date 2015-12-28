-- Table: users

DROP TABLE IF EXISTS users;

CREATE TABLE "users"
(
  "user_id" bigserial NOT NULL,
  "username" character varying NOT NULL,
  "password" text NOT NULL,
  CONSTRAINT "user_id" PRIMARY KEY (user_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "users"
  OWNER TO "postgres";

-- Table: product
CREATE TABLE "product"
(
    "product_id" bigserial NOT NULL,
    "name" character varying NOT NULL,
    "description" character varying,
    "image" bytea,
    "price" decimal
    CONSTRAINT "product_id" PRIMARY KEY (product_id)
)
ALTER TABLE "product"
  OWNER TO "postgres";
