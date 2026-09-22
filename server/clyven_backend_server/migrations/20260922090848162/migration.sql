BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "asr_job" (
    "id" bigserial PRIMARY KEY,
    "videoId" bigint NOT NULL,
    "requestedLanguageCode" text NOT NULL,
    "detectedLanguageCode" text,
    "provider" text NOT NULL,
    "status" text NOT NULL DEFAULT 'queued'::text,
    "trackId" bigint,
    "errorMessage" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "asr_job_video_idx" ON "asr_job" USING btree ("videoId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "video" ADD COLUMN "languageCode" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asr_job"
    ADD CONSTRAINT "asr_job_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260922090848162', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260922090848162', "timestamp" = now();

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
