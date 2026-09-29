BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "bio" text NOT NULL DEFAULT ''::text,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "app_profile_user_unique_idx" ON "app_profile" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "creator_follow" (
    "id" bigserial PRIMARY KEY,
    "followerId" text NOT NULL,
    "creatorId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "creator_follow_unique_idx" ON "creator_follow" USING btree ("followerId", "creatorId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "video" ADD COLUMN "contentType" text NOT NULL DEFAULT 'video'::text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "video_favorite" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "videoId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "video_favorite_unique_idx" ON "video_favorite" USING btree ("userId", "videoId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "watch_history" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "videoId" bigint NOT NULL,
    "positionSeconds" bigint NOT NULL DEFAULT 0,
    "watchedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "watch_history_unique_idx" ON "watch_history" USING btree ("userId", "videoId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "video_favorite"
    ADD CONSTRAINT "video_favorite_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "watch_history"
    ADD CONSTRAINT "watch_history_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260924032114612-merge-zh-social-content', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924032114612-merge-zh-social-content', "timestamp" = now();

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
