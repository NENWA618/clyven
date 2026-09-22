import 'admin_client.dart';

// The Admin copy of Studio's subtitle editor keeps the original Studio imports.
// Reuse the exact same authenticated Client instance rather than creating a
// second browser session.
final studioClient = adminClient;
