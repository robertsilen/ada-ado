/* File generated automatically by dynamo */
/* Entity table that enumerates all known database tables */
CREATE TABLE IF NOT EXISTS ado_entity_type (
  /* the database table unique entity index */
  "id" SERIAL,
  /* the database entity name */
  "name" VARCHAR(127) UNIQUE ,
  PRIMARY KEY ("id")
);
/* Sequence generator */
CREATE TABLE IF NOT EXISTS ado_sequence (
  /* the sequence name */
  "name" VARCHAR(127) UNIQUE NOT NULL,
  /* the sequence record version */
  "version" INTEGER NOT NULL,
  /* the sequence value */
  "value" BIGINT NOT NULL,
  /* the sequence block size */
  "block_size" BIGINT NOT NULL,
  PRIMARY KEY ("name")
);
/* Database schema version (per module) */
CREATE TABLE IF NOT EXISTS ado_version (
  /* the module name */
  "name" VARCHAR(127) UNIQUE NOT NULL,
  /* the database version schema for this module */
  "version" INTEGER NOT NULL,
  PRIMARY KEY ("name")
);
INSERT INTO ado_entity_type (name) VALUES
('ado_entity_type'), ('ado_sequence'), ('ado_version')
  ON CONFLICT DO NOTHING;
INSERT INTO ado_version (name, version)
  VALUES ("ado", 2)
  ON CONFLICT DO NOTHING;
