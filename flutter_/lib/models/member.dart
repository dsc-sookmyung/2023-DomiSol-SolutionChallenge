class Member {
  final int id;
  final String authority;
  final String email;
  final String nickname;
  final String profile_image;
  final String social_id;
  final String url;
  final String status;
  final DateTime created_at;
  final DateTime updated_at;

  Member({
    required this.id,
    required this.authority,
    required this.email,
    required this.nickname,
    required this.profile_image,
    required this.social_id,
    required this.url,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });
}
