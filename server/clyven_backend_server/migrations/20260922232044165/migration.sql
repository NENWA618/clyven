BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "script_conversion_entry" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "sourceText" text NOT NULL,
    "targetText" text NOT NULL,
    "priority" bigint NOT NULL DEFAULT 0,
    "note" text,
    "metadataJson" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "script_conversion_profile" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "languageCode" text NOT NULL,
    "sourceScriptCode" text NOT NULL,
    "targetScriptCode" text NOT NULL,
    "sheetName" text,
    "sourceColumn" text NOT NULL,
    "targetColumn" text NOT NULL,
    "priorityColumn" text,
    "noteColumn" text,
    "description" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260922232044165', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260922232044165', "timestamp" = now();

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
