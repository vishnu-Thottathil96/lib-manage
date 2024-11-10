class Author {
  final String id;
  final String name;
  final String biography;
  final String birthdate;

  Author(
      {required this.id,
      required this.name,
      required this.biography,
      required this.birthdate});

  factory Author.fromJson(Map<String, dynamic> json) {
    // Ensure that you are extracting the result field correctly
    final result = json['result'] ?? {};
    return Author(
      id: result['id'] ?? '',
      name: result['name'] ?? '',
      biography: result['biography'] ?? '',
      birthdate: result['birthdate'] ?? '',
    );
  }
}

class AuthorModel {
  final String id;
  final String name;
  final String biography;
  final String birthdate;

  AuthorModel({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthdate,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      biography: json['biography'] ?? '',
      birthdate: json['birthdate'] ?? '',
    );
  }
}
