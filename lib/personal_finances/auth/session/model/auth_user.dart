class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.plan,
    required this.gmailConnected,
    this.pictureUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String? pictureUrl;
  final String plan;
  final bool gmailConnected;
}
