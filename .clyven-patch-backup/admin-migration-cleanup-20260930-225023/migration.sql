BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_member" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "userId" text NOT NULL,
    "email" text NOT NULL,
    "roleId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "invitedByUserId" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_member_workspace_user_unique_idx" ON "admin_member" USING btree ("workspaceId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_permission" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_permission_code_unique_idx" ON "admin_permission" USING btree ("code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_role" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "key" text NOT NULL,
    "name" text NOT NULL,
    "isSystem" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_role_workspace_key_unique_idx" ON "admin_role" USING btree ("workspaceId", "key");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_role_permission" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL,
    "permissionCode" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_role_permission_unique_idx" ON "admin_role_permission" USING btree ("roleId", "permissionCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_workspace" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "ownerMemberId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "video" ADD COLUMN "seriesId" bigint;
ALTER TABLE "video" ADD COLUMN "seriesPosition" bigint;
ALTER TABLE "video" ADD COLUMN "engagedViewCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "video" ALTER COLUMN "viewCount" DROP DEFAULT;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "video_series" (
    "id" bigserial PRIMARY KEY,
    "creatorId" text NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "coverStorageKey" text,
    "languageCode" text,
    "category" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR clyven_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('clyven_backend', '20260930141519752', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260930141519752', "timestamp" = now();

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
