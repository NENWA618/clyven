import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class AdminMembershipService {
  static const defaultWorkspaceName = 'Glyphora';

  static const ownerRoleKey = 'owner';
  static const adminRoleKey = 'admin';
  static const memberRoleKey = 'member';
  static const viewerRoleKey = 'viewer';

  static const permissions = <String, String>{
    'videos.manage': 'Manage videos',
    'subtitles.manage': 'Manage subtitles',
    'dictionary.manage': 'Manage dictionary',
    'review.manage': 'Manage review',
    'members.manage': 'Manage members',
    'analytics.view': 'View analytics',
  };

  static Future<AdminWorkspace> ensureBootstrapOwner(
    Session session, {
    required String userId,
    required String email,
  }) async {
    final existing = await AdminWorkspace.db.findFirstRow(
      session,
      orderBy: (workspace) => workspace.id,
    );

    if (existing != null) {
      return existing;
    }

    late AdminWorkspace workspace;

    await session.db.transaction((transaction) async {
      final now = DateTime.now();

      workspace = await AdminWorkspace.db.insertRow(
        session,
        AdminWorkspace(
          name: defaultWorkspaceName,
          ownerMemberId: null,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );

      final workspaceId = workspace.id;
      if (workspaceId == null) {
        throw StateError('Unable to create admin workspace');
      }

      final ownerRole = await AdminRole.db.insertRow(
        session,
        AdminRole(
          workspaceId: workspaceId,
          key: ownerRoleKey,
          name: 'Owner',
          isSystem: true,
          createdAt: now,
        ),
        transaction: transaction,
      );

      final adminRole = await AdminRole.db.insertRow(
        session,
        AdminRole(
          workspaceId: workspaceId,
          key: adminRoleKey,
          name: 'Admin',
          isSystem: true,
          createdAt: now,
        ),
        transaction: transaction,
      );

      final memberRole = await AdminRole.db.insertRow(
        session,
        AdminRole(
          workspaceId: workspaceId,
          key: memberRoleKey,
          name: 'Member',
          isSystem: true,
          createdAt: now,
        ),
        transaction: transaction,
      );

      final viewerRole = await AdminRole.db.insertRow(
        session,
        AdminRole(
          workspaceId: workspaceId,
          key: viewerRoleKey,
          name: 'Viewer',
          isSystem: true,
          createdAt: now,
        ),
        transaction: transaction,
      );

      for (final entry in permissions.entries) {
        await AdminPermission.db.insertRow(
          session,
          AdminPermission(
            code: entry.key,
            name: entry.value,
            createdAt: now,
          ),
          transaction: transaction,
        );
      }

      final allCodes = permissions.keys.toList(growable: false);

      Future<void> grant(
        AdminRole role,
        Iterable<String> codes,
      ) async {
        final roleId = role.id;
        if (roleId == null) {
          throw StateError('Role id is missing');
        }

        for (final code in codes) {
          await AdminRolePermission.db.insertRow(
            session,
            AdminRolePermission(
              roleId: roleId,
              permissionCode: code,
              createdAt: now,
            ),
            transaction: transaction,
          );
        }
      }

      await grant(ownerRole, allCodes);
      await grant(adminRole, allCodes);
      await grant(
        memberRole,
        const [
          'videos.manage',
          'subtitles.manage',
          'dictionary.manage',
          'analytics.view',
        ],
      );
      await grant(viewerRole, const ['analytics.view']);

      final ownerRoleId = ownerRole.id;
      if (ownerRoleId == null) {
        throw StateError('Owner role id is missing');
      }

      final owner = await AdminMember.db.insertRow(
        session,
        AdminMember(
          workspaceId: workspaceId,
          userId: userId,
          email: email.trim().toLowerCase(),
          roleId: ownerRoleId,
          status: 'active',
          invitedByUserId: null,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );

      if (owner.id == null) {
        throw StateError('Owner member id is missing');
      }

      workspace = await AdminWorkspace.db.updateRow(
        session,
        workspace.copyWith(
          ownerMemberId: owner.id,
          updatedAt: now,
        ),
        transaction: transaction,
      );
    });

    return workspace;
  }

  static Future<AdminWorkspace> requireWorkspace(Session session) async {
    final workspace = await AdminWorkspace.db.findFirstRow(
      session,
      orderBy: (row) => row.id,
    );

    if (workspace == null || workspace.ownerMemberId == null) {
      throw Exception('Admin workspace has not been initialized');
    }

    return workspace;
  }

  static Future<AdminMember> requireCurrentMember(
    Session session,
    AdminWorkspace workspace,
  ) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw Exception('Login required');
    }

    final userId = auth.userIdentifier.toString();
    final workspaceId = workspace.id;
    if (workspaceId == null) {
      throw Exception('Invalid workspace');
    }

    final member = await AdminMember.db.findFirstRow(
      session,
      where: (row) =>
          row.workspaceId.equals(workspaceId) &
          row.userId.equals(userId) &
          row.status.equals('active'),
    );

    if (member == null) {
      throw Exception('You are not a member of this admin workspace');
    }

    return member;
  }

  static bool isOwner(
    AdminWorkspace workspace,
    AdminMember member,
  ) {
    return workspace.ownerMemberId != null &&
        workspace.ownerMemberId == member.id;
  }

  static Future<bool> hasPermission(
    Session session, {
    required AdminWorkspace workspace,
    required AdminMember member,
    required String permissionCode,
  }) async {
    if (isOwner(workspace, member)) {
      return true;
    }

    final rolePermissions = await AdminRolePermission.db.find(
      session,
      where: (row) =>
          row.roleId.equals(member.roleId) &
          row.permissionCode.equals(permissionCode),
      limit: 1,
    );

    return rolePermissions.isNotEmpty;
  }

  static Future<void> requirePermission(
    Session session, {
    required AdminWorkspace workspace,
    required AdminMember member,
    required String permissionCode,
  }) async {
    if (!await hasPermission(
      session,
      workspace: workspace,
      member: member,
      permissionCode: permissionCode,
    )) {
      throw Exception('Permission denied: $permissionCode');
    }
  }

  static Future<AdminRole> requireRole(
    Session session, {
    required int workspaceId,
    required int roleId,
  }) async {
    final role = await AdminRole.db.findById(session, roleId);

    if (role == null || role.workspaceId != workspaceId) {
      throw Exception('Role not found');
    }

    return role;
  }

  static Future<AdminRole> requireRoleByKey(
    Session session, {
    required int workspaceId,
    required String key,
    Transaction? transaction,
  }) async {
    final role = await AdminRole.db.findFirstRow(
      session,
      where: (row) => row.workspaceId.equals(workspaceId) & row.key.equals(key),
      transaction: transaction,
    );

    if (role == null) {
      throw Exception('Role not found: $key');
    }

    return role;
  }
}
