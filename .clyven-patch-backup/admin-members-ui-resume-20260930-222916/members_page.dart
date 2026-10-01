import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/admin_client.dart';

class MembersPage extends StatefulComponent {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final client = adminClient;

  AdminWorkspace? _workspace;
  List<AdminMember> _members = [];
  List<AdminRole> _roles = [];
  List<AdminPermission> _permissions = [];

  final Map<int, Set<String>> _rolePermissions = {};

  bool _loading = true;
  bool _saving = false;
  String? _error;
  String? _success;

  String _newEmail = '';
  int? _newRoleId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _success = null;
    });

    try {
      final workspace = await client.adminMembership.getWorkspace();
      final members = await client.adminMembership.listMembers();
      final roles = await client.adminMembership.listRoles();
      final permissions = await client.adminMembership.listPermissions();

      final rolePermissions = <int, Set<String>>{};
      for (final role in roles) {
        final roleId = role.id;
        if (roleId == null) continue;

        final rows = await client.adminMembership.listRolePermissions(
          roleId: roleId,
        );

        rolePermissions[roleId] = rows
            .map((row) => row.permissionCode)
            .toSet();
      }

      if (!mounted) return;

      final nonOwnerRoles = roles.where((role) => role.key != 'owner').toList();

      setState(() {
        _workspace = workspace;
        _members = members;
        _roles = roles;
        _permissions = permissions;
        _rolePermissions
          ..clear()
          ..addAll(rolePermissions);
        _newRoleId ??= nonOwnerRoles.isEmpty ? null : nonOwnerRoles.first.id;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  AdminRole? _roleFor(int roleId) {
    for (final role in _roles) {
      if (role.id == roleId) return role;
    }
    return null;
  }

  String _roleName(int roleId) {
    return _roleFor(roleId)?.name ?? 'Unknown';
  }

  bool _isOwner(AdminMember member) {
    return member.id != null && member.id == _workspace?.ownerMemberId;
  }

  Future<void> _runMutation(
    Future<void> Function() action, {
    required String success,
  }) async {
    if (_saving) return;

    setState(() {
      _saving = true;
      _error = null;
      _success = null;
    });

    try {
      await action();
      if (!mounted) return;

      setState(() {
        _saving = false;
        _success = success;
      });

      await _load();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _saving = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _addMember() async {
    final email = _newEmail.trim().toLowerCase();
    final roleId = _newRoleId;

    if (email.isEmpty || roleId == null) {
      setState(() {
        _error = '请输入邮箱并选择角色。';
      });
      return;
    }

    await _runMutation(
      () async {
        await client.adminMembership.addMemberByEmail(
          email: email,
          roleId: roleId,
        );
      },
      success: '成员已添加。',
    );

    if (mounted) {
      setState(() {
        _newEmail = '';
      });
    }
  }

  Future<void> _changeRole(AdminMember member, int roleId) async {
    final memberId = member.id;
    if (memberId == null) return;

    await _runMutation(
      () async {
        await client.adminMembership.updateMemberRole(
          memberId: memberId,
          roleId: roleId,
        );
      },
      success: '角色已更新。',
    );
  }

  Future<void> _removeMember(AdminMember member) async {
    final memberId = member.id;
    if (memberId == null) return;

    await _runMutation(
      () async {
        await client.adminMembership.removeMember(memberId: memberId);
      },
      success: '成员已移除。',
    );
  }

  Future<void> _transferOwnership(AdminMember member) async {
    final memberId = member.id;
    if (memberId == null) return;

    await _runMutation(
      () async {
        await client.adminMembership.transferOwnership(
          newOwnerMemberId: memberId,
        );
      },
      success: 'Owner 已转移。',
    );
  }

  void _togglePermission(int roleId, String code) {
    final current = Set<String>.from(_rolePermissions[roleId] ?? const {});
    if (current.contains(code)) {
      current.remove(code);
    } else {
      current.add(code);
    }

    setState(() {
      _rolePermissions[roleId] = current;
    });
  }

  Future<void> _saveRolePermissions(AdminRole role) async {
    final roleId = role.id;
    if (roleId == null) return;

    final codes = (_rolePermissions[roleId] ?? const <String>{}).toList()
      ..sort();

    await _runMutation(
      () async {
        await client.adminMembership.setRolePermissions(
          roleId: roleId,
          permissionCodes: codes,
        );
      },
      success: '${role.name} 权限已保存。',
    );
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(classes: 'admin-members-state', [
        .text('正在读取成员和权限…'),
      ]);
    }

    return div(classes: 'admin-members-page', [
      div(classes: 'admin-members-heading', [
        div([
          h2([.text('成员与权限')]),
          p([
            .text(
              'Owner 永远唯一。管理员、成员与查看者通过 Role + Permission 管理。',
            ),
          ]),
        ]),
        button(
          type: ButtonType.button,
          classes: 'admin-secondary-button',
          onClick: _saving ? null : _load,
          [.text('刷新')],
        ),
      ]),
      if (_error != null)
        div(classes: 'admin-error admin-page-error', [.text(_error!)]),
      if (_success != null)
        div(classes: 'admin-members-success', [.text(_success!)]),
      section(classes: 'admin-members-card admin-members-add-card', [
        div(classes: 'admin-members-card-title', [
          div([
            strong([.text('添加成员')]),
            span([.text('成员必须先拥有已注册的 Clyven 账号。')]),
          ]),
        ]),
        div(classes: 'admin-members-add-form', [
          input<String>(
            type: InputType.email,
            attributes: {
              'placeholder': 'member@example.com',
              'value': _newEmail,
            },
            events: events<String>(
              onInput: (value) {
                _newEmail = value;
              },
            ),
          ),
          div(classes: 'admin-role-choice-row', [
            for (final role in _roles.where((role) => role.key != 'owner'))
              button(
                type: ButtonType.button,
                classes:
                    'admin-role-choice${_newRoleId == role.id ? ' is-selected' : ''}',
                onClick: () {
                  setState(() {
                    _newRoleId = role.id;
                  });
                },
                [.text(role.name)],
              ),
          ]),
          button(
            type: ButtonType.button,
            classes: 'admin-primary-button',
            attributes: _saving ? {'disabled': 'disabled'} : null,
            onClick: _saving ? null : _addMember,
            [.text(_saving ? '处理中…' : '添加成员')],
          ),
        ]),
      ]),
      section(classes: 'admin-members-card', [
        div(classes: 'admin-members-card-title', [
          div([
            strong([.text('成员')]),
            span([.text('${_members.length} total')]),
          ]),
        ]),
        div(classes: 'admin-members-list', [
          for (final member in _members)
            div(
              classes:
                  'admin-member-row${member.status == 'active' ? '' : ' is-removed'}',
              [
                div(classes: 'admin-member-identity', [
                  div(classes: 'admin-member-avatar', [
                    .text(
                      member.email.trim().isEmpty
                          ? '?'
                          : member.email.substring(0, 1).toUpperCase(),
                    ),
                  ]),
                  div([
                    strong([.text(member.email)]),
                    span([
                      .text(
                        _isOwner(member)
                            ? 'OWNER · protected'
                            : '${_roleName(member.roleId)} · ${member.status}',
                      ),
                    ]),
                  ]),
                ]),
                if (member.status == 'active')
                  div(classes: 'admin-member-actions', [
                    if (_isOwner(member))
                      span(classes: 'admin-owner-badge', [.text('OWNER')])
                    else ...[
                      for (final role
                          in _roles.where((role) => role.key != 'owner'))
                        button(
                          type: ButtonType.button,
                          classes:
                              'admin-mini-button${member.roleId == role.id ? ' is-current' : ''}',
                          onClick: _saving || member.roleId == role.id
                              ? null
                              : () => _changeRole(member, role.id!),
                          [.text(role.name)],
                        ),
                      button(
                        type: ButtonType.button,
                        classes: 'admin-mini-button admin-transfer-button',
                        onClick: _saving
                            ? null
                            : () => _transferOwnership(member),
                        [.text('Transfer Owner')],
                      ),
                      button(
                        type: ButtonType.button,
                        classes: 'admin-mini-button admin-danger-button',
                        onClick:
                            _saving ? null : () => _removeMember(member),
                        [.text('Remove')],
                      ),
                    ],
                  ]),
              ],
            ),
        ]),
      ]),
      section(classes: 'admin-members-card', [
        div(classes: 'admin-members-card-title', [
          div([
            strong([.text('角色权限')]),
            span([
              .text(
                'Owner 拥有隐式全部权限，不允许通过这里修改。',
              ),
            ]),
          ]),
        ]),
        div(classes: 'admin-role-permission-grid', [
          for (final role in _roles.where((role) => role.key != 'owner'))
            div(classes: 'admin-role-permission-card', [
              div(classes: 'admin-role-permission-header', [
                div([
                  strong([.text(role.name)]),
                  span([.text(role.key)]),
                ]),
                button(
                  type: ButtonType.button,
                  classes: 'admin-primary-button',
                  onClick:
                      _saving ? null : () => _saveRolePermissions(role),
                  [.text('Save')],
                ),
              ]),
              div(classes: 'admin-permission-list', [
                for (final permission in _permissions)
                  button(
                    type: ButtonType.button,
                    classes:
                        'admin-permission-toggle${(_rolePermissions[role.id] ?? const <String>{}).contains(permission.code) ? ' is-enabled' : ''}',
                    onClick: () =>
                        _togglePermission(role.id!, permission.code),
                    [
                      span(classes: 'admin-permission-check', [
                        .text(
                          (_rolePermissions[role.id] ?? const <String>{})
                                  .contains(permission.code)
                              ? '✓'
                              : '',
                        ),
                      ]),
                      div([
                        strong([.text(permission.name)]),
                        span([.text(permission.code)]),
                      ]),
                    ],
                  ),
              ]),
            ]),
        ]),
      ]),
    ]);
  }
}
