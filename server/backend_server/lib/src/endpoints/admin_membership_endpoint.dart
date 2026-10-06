import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import '../services/admin_membership_service.dart';

class AdminMembershipEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AdminWorkspace> getWorkspace(Session session) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    await AdminMembershipService.requireCurrentMember(session, workspace);
    return workspace;
  }

  Future<List<AdminMember>> listMembers(Session session) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    await AdminMembershipService.requireCurrentMember(session, workspace);

    final workspaceId = workspace.id!;

    return AdminMember.db.find(
      session,
      where: (row) => row.workspaceId.equals(workspaceId),
      orderBy: (row) => row.createdAt,
    );
  }

  Future<List<AdminRole>> listRoles(Session session) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    await AdminMembershipService.requireCurrentMember(session, workspace);

    return AdminRole.db.find(
      session,
      where: (row) => row.workspaceId.equals(workspace.id!),
      orderBy: (row) => row.id,
    );
  }

  Future<List<AdminPermission>> listPermissions(Session session) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    await AdminMembershipService.requireCurrentMember(session, workspace);

    return AdminPermission.db.find(
      session,
      orderBy: (row) => row.code,
    );
  }

  Future<List<AdminRolePermission>> listRolePermissions(
    Session session, {
    required int roleId,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    await AdminMembershipService.requireCurrentMember(session, workspace);

    await AdminMembershipService.requireRole(
      session,
      workspaceId: workspace.id!,
      roleId: roleId,
    );

    return AdminRolePermission.db.find(
      session,
      where: (row) => row.roleId.equals(roleId),
      orderBy: (row) => row.permissionCode,
    );
  }

  Future<AdminMember> addMemberByEmail(
    Session session, {
    required String email,
    required int roleId,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    final actor = await AdminMembershipService.requireCurrentMember(
      session,
      workspace,
    );

    await AdminMembershipService.requirePermission(
      session,
      workspace: workspace,
      member: actor,
      permissionCode: 'members.manage',
    );

    final workspaceId = workspace.id!;
    final role = await AdminMembershipService.requireRole(
      session,
      workspaceId: workspaceId,
      roleId: roleId,
    );

    if (role.key == AdminMembershipService.ownerRoleKey) {
      throw Exception('Owner can only be changed through transferOwnership');
    }

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) {
      throw Exception('Email is required');
    }

    final account = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: normalizedEmail,
    );

    if (account == null) {
      throw Exception('No registered Glyphora account found for this email');
    }

    final userId = account.authUserId.toString();

    final existing = await AdminMember.db.findFirstRow(
      session,
      where: (row) =>
          row.workspaceId.equals(workspaceId) & row.userId.equals(userId),
    );

    if (existing != null) {
      if (existing.status == 'active') {
        throw Exception('This user is already a member');
      }

      return AdminMember.db.updateRow(
        session,
        existing.copyWith(
          email: normalizedEmail,
          roleId: roleId,
          status: 'active',
          invitedByUserId: actor.userId,
          updatedAt: DateTime.now(),
        ),
      );
    }

    final now = DateTime.now();

    return AdminMember.db.insertRow(
      session,
      AdminMember(
        workspaceId: workspaceId,
        userId: userId,
        email: normalizedEmail,
        roleId: roleId,
        status: 'active',
        invitedByUserId: actor.userId,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<AdminMember> updateMemberRole(
    Session session, {
    required int memberId,
    required int roleId,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    final actor = await AdminMembershipService.requireCurrentMember(
      session,
      workspace,
    );

    await AdminMembershipService.requirePermission(
      session,
      workspace: workspace,
      member: actor,
      permissionCode: 'members.manage',
    );

    if (workspace.ownerMemberId == memberId) {
      throw Exception('Owner role cannot be changed directly');
    }

    final target = await AdminMember.db.findById(session, memberId);
    if (target == null || target.workspaceId != workspace.id) {
      throw Exception('Member not found');
    }

    final role = await AdminMembershipService.requireRole(
      session,
      workspaceId: workspace.id!,
      roleId: roleId,
    );

    if (role.key == AdminMembershipService.ownerRoleKey) {
      throw Exception('Use transferOwnership to assign Owner');
    }

    return AdminMember.db.updateRow(
      session,
      target.copyWith(
        roleId: roleId,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<bool> removeMember(
    Session session, {
    required int memberId,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    final actor = await AdminMembershipService.requireCurrentMember(
      session,
      workspace,
    );

    await AdminMembershipService.requirePermission(
      session,
      workspace: workspace,
      member: actor,
      permissionCode: 'members.manage',
    );

    if (workspace.ownerMemberId == memberId) {
      throw Exception('Owner cannot be removed');
    }

    final target = await AdminMember.db.findById(session, memberId);
    if (target == null || target.workspaceId != workspace.id) {
      throw Exception('Member not found');
    }

    await AdminMember.db.updateRow(
      session,
      target.copyWith(
        status: 'removed',
        updatedAt: DateTime.now(),
      ),
    );

    return true;
  }

  Future<AdminWorkspace> transferOwnership(
    Session session, {
    required int newOwnerMemberId,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    final actor = await AdminMembershipService.requireCurrentMember(
      session,
      workspace,
    );

    if (!AdminMembershipService.isOwner(workspace, actor)) {
      throw Exception('Only the current Owner can transfer ownership');
    }

    if (newOwnerMemberId == actor.id) {
      return workspace;
    }

    final newOwner = await AdminMember.db.findById(session, newOwnerMemberId);
    if (newOwner == null ||
        newOwner.workspaceId != workspace.id ||
        newOwner.status != 'active') {
      throw Exception('New owner must be an active workspace member');
    }

    late AdminWorkspace updatedWorkspace;

    await session.db.transaction((transaction) async {
      final ownerRole = await AdminMembershipService.requireRoleByKey(
        session,
        workspaceId: workspace.id!,
        key: AdminMembershipService.ownerRoleKey,
        transaction: transaction,
      );

      final adminRole = await AdminMembershipService.requireRoleByKey(
        session,
        workspaceId: workspace.id!,
        key: AdminMembershipService.adminRoleKey,
        transaction: transaction,
      );

      final ownerRoleId = ownerRole.id!;
      final adminRoleId = adminRole.id!;
      final now = DateTime.now();

      await AdminMember.db.updateRow(
        session,
        actor.copyWith(
          roleId: adminRoleId,
          updatedAt: now,
        ),
        transaction: transaction,
      );

      await AdminMember.db.updateRow(
        session,
        newOwner.copyWith(
          roleId: ownerRoleId,
          updatedAt: now,
        ),
        transaction: transaction,
      );

      updatedWorkspace = await AdminWorkspace.db.updateRow(
        session,
        workspace.copyWith(
          ownerMemberId: newOwnerMemberId,
          updatedAt: now,
        ),
        transaction: transaction,
      );
    });

    return updatedWorkspace;
  }

  Future<bool> setRolePermissions(
    Session session, {
    required int roleId,
    required List<String> permissionCodes,
  }) async {
    final workspace = await AdminMembershipService.requireWorkspace(session);
    final actor = await AdminMembershipService.requireCurrentMember(
      session,
      workspace,
    );

    if (!AdminMembershipService.isOwner(workspace, actor)) {
      throw Exception('Only Owner can change role permissions');
    }

    final role = await AdminMembershipService.requireRole(
      session,
      workspaceId: workspace.id!,
      roleId: roleId,
    );

    if (role.key == AdminMembershipService.ownerRoleKey) {
      throw Exception('Owner permissions are implicit and cannot be edited');
    }

    final allowed = AdminMembershipService.permissions.keys.toSet();
    final requested = permissionCodes.toSet();

    if (!allowed.containsAll(requested)) {
      throw Exception('Unknown permission code');
    }

    await session.db.transaction((transaction) async {
      await AdminRolePermission.db.deleteWhere(
        session,
        where: (row) => row.roleId.equals(roleId),
        transaction: transaction,
      );

      for (final code in requested) {
        await AdminRolePermission.db.insertRow(
          session,
          AdminRolePermission(
            roleId: roleId,
            permissionCode: code,
            createdAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      }
    });

    return true;
  }
}
