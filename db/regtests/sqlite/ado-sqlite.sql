/* File generated automatically by dynamo */
/* This is the Audit_Info table */
CREATE TABLE audit_info (
  /*  */
  `id` BIGINT ,
  /* the entity id */
  `entity_id` BIGINT ,
  /* the entity type */
  `entity_type` INTEGER NOT NULL,
  /* the old value */
  `old_value` VARCHAR(255) ,
  /* the new value */
  `new_value` VARCHAR(255) ,
  /* the audit date */
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
);
/* This is the User email table */
CREATE TABLE audit_email (
  /*  */
  `id` BIGINT NOT NULL,
  /* the user email address */
  `user_email` VARCHAR(32) ,
  /* the user email status */
  `email_status` INTEGER ,
  PRIMARY KEY (`id`)
);
/* This is a generic property */
CREATE TABLE audit_property (
  /*  */
  `id` VARCHAR(255) NOT NULL,
  /* the property value */
  `user_email` INTEGER ,
  /* a float property value */
  `float_value`  NOT NULL,
  PRIMARY KEY (`id`)
);
/* The Comment table records a user comment associated with a database entity.
                 The comment can be associated with any other database record. */
CREATE TABLE TEST_COMMENTS (
  /* the comment identifier */
  `ID` INTEGER ,
  /* the comment version. */
  `version` INTEGER NOT NULL,
  /* the comment publication date. */
  `DATE` TIMESTAMP NOT NULL,
  /* the comment message. */
  `MESSAGE` VARCHAR(256) NOT NULL,
  /* the entity identifier to which this comment is associated. */
  `ENTITY_ID` INTEGER NOT NULL,
  /* the user who posted this comment */
  `USER_FK` INTEGER NOT NULL,
  /* the entity type that correspond to the entity associated with this comment. */
  `ENTITY__TYPE_FK` INTEGER NOT NULL,
  PRIMARY KEY (`ID`)
);
/*  */
CREATE TABLE test_image (
  /* the image identifier */
  `id` INTEGER ,
  /* the image version. */
  `version` INTEGER NOT NULL,
  /* the message creation date */
  `create_date` DATETIME NOT NULL,
  /* the image data */
  `image` LONGBLOB ,
  PRIMARY KEY (`id`)
);
/* Record representing a user */
CREATE TABLE allocate (
  /* the user id */
  `ID` BIGINT NOT NULL,
  /* the allocate version. */
  `version` INTEGER NOT NULL,
  /* the sequence value */
  `NAME` VARCHAR(255) ,
  PRIMARY KEY (`ID`)
);
/* Record representing a user */
CREATE TABLE test_user (
  /* the user id */
  `ID` BIGINT NOT NULL,
  /* the comment version. */
  `version` INTEGER NOT NULL,
  /* the sequence value */
  `VALUE` BIGINT NOT NULL,
  /* the user name */
  `NAME` VARCHAR(255) ,
  /* the user name */
  `select` VARCHAR(255) ,
  PRIMARY KEY (`ID`)
);
/* Record representing a user */
CREATE TABLE test_nullable_table (
  /* the user id */
  `ID` BIGINT NOT NULL,
  /* the comment version. */
  `version` INTEGER NOT NULL,
  /* an identifier value */
  `ID_VALUE` BIGINT ,
  /* an integer value */
  `INT_VALUE` INTEGER ,
  /* a boolean value */
  `BOOL_VALUE` TINYINT ,
  /* a string value */
  `STRING_VALUE` VARCHAR(255) ,
  /* a time value */
  `TIME_VALUE` DATETIME ,
  /* an entity value */
  `ENTITY_VALUE` INTEGER ,
  PRIMARY KEY (`ID`)
);
/* Record representing a user */
CREATE TABLE test_table (
  /* the user id */
  `ID` BIGINT NOT NULL,
  /* the comment version. */
  `version` INTEGER NOT NULL,
  /* an identifier value */
  `ID_VALUE` BIGINT NOT NULL,
  /* an integer value */
  `INT_VALUE` INTEGER NOT NULL,
  /* a boolean value */
  `BOOL_VALUE` TINYINT NOT NULL,
  /* a string value */
  `STRING_VALUE` VARCHAR(255) NOT NULL,
  /* a time value */
  `TIME_VALUE` DATETIME NOT NULL,
  /* an entity value */
  `ENTITY_VALUE` INTEGER NOT NULL,
  PRIMARY KEY (`ID`)
);
INSERT INTO entity_type (name) VALUES ("audit_info");
INSERT INTO entity_type (name) VALUES ("audit_email");
INSERT INTO entity_type (name) VALUES ("audit_property");
INSERT INTO entity_type (name) VALUES ("TEST_COMMENTS");
INSERT INTO entity_type (name) VALUES ("test_image");
INSERT INTO entity_type (name) VALUES ("allocate");
INSERT INTO entity_type (name) VALUES ("test_user");
INSERT INTO entity_type (name) VALUES ("test_nullable_table");
INSERT INTO entity_type (name) VALUES ("test_table");
