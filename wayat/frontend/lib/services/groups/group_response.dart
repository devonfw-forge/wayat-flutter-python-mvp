class GroupResponse {
  String id;
  List<String> members;
  String name;
  String imageUrl;

  GroupResponse({
    required this.id,
    required this.members,
    required this.name,
    required this.imageUrl,
  });

  factory GroupResponse.fromMap(Map<String, dynamic> map) {
    return GroupResponse(
      id: map['id'] as String,
      members:
          (map["members"] as List<dynamic>).map((e) => e.toString()).toList(),
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
    );
  }
}
