class Tag {
  final int id;
  final String status;
  final DateTime created_at;
  final DateTime updated_at;
  final int member_id;

  Tag({
    required this.id,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.member_id,
  });
}
