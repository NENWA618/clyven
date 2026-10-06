BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "recipientId" text NOT NULL,
    "actorId" text NOT NULL,
    "actorName" text NOT NULL,
    "type" text NOT NULL,
    "videoId" bigint,
    "commentPreview" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "notification_recipient_idx" ON "notification" USING btree ("recipientId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "video_like" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "videoId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "video_like_unique_idx" ON "video_like" USING btree ("userId", "videoId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "video_like"
    ADD CONSTRAINT "video_like_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR glyphora_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('glyphora_backend', '20260928111955310-add-notifications-and-video-likes', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928111955310-add-notifications-and-video-likes', "timestamp" = now();

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
