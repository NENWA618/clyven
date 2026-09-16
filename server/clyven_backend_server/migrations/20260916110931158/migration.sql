BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dictionary_example" (
    "id" bigserial PRIMARY KEY,
    "entryId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dictionary_example_text" (
    "id" bigserial PRIMARY KEY,
    "exampleId" bigint NOT NULL,
    "languageCode" text NOT NULL,
    "scriptCode" text NOT NULL,
    "text" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "dictionary_example_text_unique_idx" ON "dictionary_example_text" USING btree ("exampleId", "languageCode", "scriptCode");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dictionary_example"
    ADD CONSTRAINT "dictionary_example_fk_0"
    FOREIGN KEY("entryId")
    REFERENCES "dictionary_entry"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dictionary_example_text"
    ADD CONSTRAINT "dictionary_example_text_fk_0"
    FOREIGN KEY("exampleId")
    REFERENCES "dictionary_example"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260916110931158', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916110931158', "timestamp" = now();

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
