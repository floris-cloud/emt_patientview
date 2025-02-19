class Icd {
  String title;
  String description;

  Icd({required this.title, required this.description});

  factory Icd.fromJson(Map<String, dynamic> json) {
    return Icd(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };

  @override
  String toString() {
    return 'Icd{title: $title, description: $description}';
  }
}