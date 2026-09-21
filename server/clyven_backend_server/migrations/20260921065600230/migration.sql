BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subtitle_cue_text" (
    "id" bigserial PRIMARY KEY,
    "cueId" bigint NOT NULL,
    "scriptCode" text NOT NULL,
    "text" text NOT NULL,
    "normalizedText" text,
    "isPrimary" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "subtitle_cue_text_unique_idx" ON "subtitle_cue_text" USING btree ("cueId", "scriptCode");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subtitle_phrase" ADD COLUMN "scriptCode" text;
ALTER TABLE "subtitle_phrase" ADD COLUMN "entryId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subtitle_token" ADD COLUMN "scriptCode" text;
ALTER TABLE "subtitle_token" ADD COLUMN "entryId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "subtitle_track" ADD COLUMN "variantCode" text;
ALTER TABLE "subtitle_track" ADD COLUMN "defaultScriptCode" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_cue_text"
    ADD CONSTRAINT "subtitle_cue_text_fk_0"
    FOREIGN KEY("cueId")
    REFERENCES "subtitle_cue"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_phrase"
    ADD CONSTRAINT "subtitle_phrase_fk_1"
    FOREIGN KEY("entryId")
    REFERENCES "dictionary_entry"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_token"
    ADD CONSTRAINT "subtitle_token_fk_1"
    FOREIGN KEY("entryId")
    REFERENCES "dictionary_entry"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260921065600230', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260921065600230', "timestamp" = now();

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
