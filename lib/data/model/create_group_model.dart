class Group {
  final String guid;
  final String name;
  final String groupType;
  final String password;
  final String icon;
  final String description;
  final String owner;
  final Map<String, dynamic> metadata;

  Group({
    required this.guid,
    required this.name,
    required this.groupType,
    required this.password,
    required this.icon,
    required this.description,
    required this.owner,
    required this.metadata,
  });
}
