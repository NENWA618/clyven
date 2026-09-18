BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment_like" (
    "id" bigserial PRIMARY KEY,
    "commentId" bigint NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "comment_like_unique_idx" ON "comment_like" USING btree ("commentId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment_reply" (
    "id" bigserial PRIMARY KEY,
    "commentId" bigint NOT NULL,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "content" text NOT NULL,
    "likeCount" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "comment_reply_comment_idx" ON "comment_reply" USING btree ("commentId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment_reply_like" (
    "id" bigserial PRIMARY KEY,
    "replyId" bigint NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "comment_reply_like_unique_idx" ON "comment_reply_like" USING btree ("replyId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "video_comment" (
    "id" bigserial PRIMARY KEY,
    "videoId" bigint NOT NULL,
    "userId" text NOT NULL,
    "userName" text NOT NULL,
    "content" text NOT NULL,
    "likeCount" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "video_comment_video_idx" ON "video_comment" USING btree ("videoId");


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260917094846481', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260917094846481', "timestamp" = now();

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
