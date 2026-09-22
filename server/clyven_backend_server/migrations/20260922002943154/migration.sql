BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subtitle_publish_state" (
    "id" bigserial PRIMARY KEY,
    "trackId" bigint NOT NULL,
    "publishedPayload" text,
    "publishedAt" timestamp without time zone,
    "draftRevision" bigint NOT NULL DEFAULT 0,
    "publishedRevision" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "subtitle_publish_state_track_unique_idx" ON "subtitle_publish_state" USING btree ("trackId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_publish_state"
    ADD CONSTRAINT "subtitle_publish_state_fk_0"
    FOREIGN KEY("trackId")
    REFERENCES "subtitle_track"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260922002943154', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260922002943154', "timestamp" = now();

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
