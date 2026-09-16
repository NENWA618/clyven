BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dictionary_import_mapping" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "sourceColumn" text NOT NULL,
    "targetType" text NOT NULL,
    "targetField" text,
    "languageCode" text,
    "scriptCode" text,
    "relationType" text,
    "groupKey" text,
    "position" bigint NOT NULL,
    "required" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dictionary_import_profile" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "languageCode" text NOT NULL,
    "sheetName" text NOT NULL,
    "defaultEntryType" text,
    "primaryScriptCode" text,
    "description" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dictionary_import_mapping"
    ADD CONSTRAINT "dictionary_import_mapping_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "dictionary_import_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260916111645230', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916111645230', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
