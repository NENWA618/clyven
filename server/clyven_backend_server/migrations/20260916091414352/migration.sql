BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dictionary_relation" (
    "id" bigserial PRIMARY KEY,
    "sourceEntryId" bigint NOT NULL,
    "targetEntryId" bigint NOT NULL,
    "relationType" text NOT NULL,
    "position" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dictionary_relation"
    ADD CONSTRAINT "dictionary_relation_fk_0"
    FOREIGN KEY("sourceEntryId")
    REFERENCES "dictionary_entry"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "dictionary_relation"
    ADD CONSTRAINT "dictionary_relation_fk_1"
    FOREIGN KEY("targetEntryId")
    REFERENCES "dictionary_entry"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260916091414352', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916091414352', "timestamp" = now();

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
