BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "video" ADD COLUMN "videoStorageId" text;
ALTER TABLE "video" ADD COLUMN "coverStorageId" text;

--
-- MIGRATION VERSION FOR glyphora_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('glyphora_backend', '20261022090527013', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261022090527013', "timestamp" = now();

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
