BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification_settings" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "pushEnabled" boolean NOT NULL DEFAULT true,
    "likeEnabled" boolean NOT NULL DEFAULT true,
    "commentEnabled" boolean NOT NULL DEFAULT true,
    "followEnabled" boolean NOT NULL DEFAULT true,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "notification_settings_user_unique_idx" ON "notification_settings" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "privacy_settings" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "privateAccount" boolean NOT NULL DEFAULT false,
    "allowComments" boolean NOT NULL DEFAULT true,
    "showActivityStatus" boolean NOT NULL DEFAULT true,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "privacy_settings_user_unique_idx" ON "privacy_settings" USING btree ("userId");


--
-- MIGRATION VERSION FOR glyphora_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('glyphora_backend', '20260928104145422-add-privacy-notification-settings', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928104145422-add-privacy-notification-settings', "timestamp" = now();

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
