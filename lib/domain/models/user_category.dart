import 'dart:convert';

class UserCategory {
  UserCategory({
    required this.id,
    required this.name,
  });

  final List<int> id;
  final List<String> name;

  factory UserCategory.fromRawJson(String str) =>
      UserCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
        id: List<int>.from(json["id"].map((x) => x)),
        name: List<String>.from(json["name"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": List<dynamic>.from(id.map((x) => x)),
        "name": List<dynamic>.from(name.map((x) => x)),
      };
}
