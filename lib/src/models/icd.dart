class Icd {
  String code;
  String description;

  Icd({required this.code, required this.description});

  factory Icd.fromJson(Map<String, dynamic> json) {
    return Icd(
      code: json['code'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'description': description,
  };

  @override
  String toString() {
    return 'Icd{code: $code, description: $description}';
  }
}