BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "video" ADD COLUMN "hlsManifestStorageKey" text;
ALTER TABLE "video" ADD COLUMN "transcoderJobName" text;
ALTER TABLE "video" ADD COLUMN "transcodeState" text;

--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260923041312794', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260923041312794', "timestamp" = now();

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
