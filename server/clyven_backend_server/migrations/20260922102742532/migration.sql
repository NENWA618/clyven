BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subtitle_review_event" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "actorUserId" text,
    "actorDisplayName" text,
    "action" text NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "subtitle_review_event_task_idx" ON "subtitle_review_event" USING btree ("taskId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subtitle_review_task" (
    "id" bigserial PRIMARY KEY,
    "videoId" bigint NOT NULL,
    "trackId" bigint NOT NULL,
    "languageCode" text NOT NULL,
    "scriptCode" text,
    "status" text NOT NULL DEFAULT 'readyForReview'::text,
    "priority" bigint NOT NULL DEFAULT 0,
    "assignedUserId" text,
    "assignedDisplayName" text,
    "editedByUserId" text,
    "editedByDisplayName" text,
    "reviewedByUserId" text,
    "reviewedByDisplayName" text,
    "approvedByUserId" text,
    "approvedByDisplayName" text,
    "claimedAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "submittedAt" timestamp without time zone,
    "reviewedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "publishedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "subtitle_review_task_track_script_idx" ON "subtitle_review_task" USING btree ("trackId", "scriptCode");
CREATE INDEX "subtitle_review_task_status_idx" ON "subtitle_review_task" USING btree ("status");
CREATE INDEX "subtitle_review_task_assigned_idx" ON "subtitle_review_task" USING btree ("assignedUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_review_event"
    ADD CONSTRAINT "subtitle_review_event_fk_0"
    FOREIGN KEY("taskId")
    REFERENCES "subtitle_review_task"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subtitle_review_task"
    ADD CONSTRAINT "subtitle_review_task_fk_0"
    FOREIGN KEY("videoId")
    REFERENCES "video"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "subtitle_review_task"
    ADD CONSTRAINT "subtitle_review_task_fk_1"
    FOREIGN KEY("trackId")
    REFERENCES "subtitle_track"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260922102742532', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260922102742532', "timestamp" = now();

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
