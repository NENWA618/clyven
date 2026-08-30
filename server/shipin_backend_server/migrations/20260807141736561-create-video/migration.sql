BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "video" (
    "id" bigserial PRIMARY KEY,
    "authorId" text NOT NULL,
    "authorName" text NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "category" text NOT NULL,
    "tags" json NOT NULL,
    "videoStorageKey" text NOT NULL,
    "coverStorageKey" text,
    "durationSeconds" bigint NOT NULL,
    "viewCount" bigint NOT NULL DEFAULT 0,
    "likeCount" bigint NOT NULL DEFAULT 0,
    "favoriteCount" bigint NOT NULL DEFAULT 0,
    "commentCount" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL DEFAULT 'uploading'::text,
    "publishedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR shipin_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('shipin_backend', '20260807141736561-create-video', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260807141736561-create-video', "timestamp" = now();

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
