-- Table: users


DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id bigserial NOT NULL,
  username character varying NOT NULL,
  password text NOT NULL,
  CONSTRAINT id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE users
  OWNER TO postgres;

