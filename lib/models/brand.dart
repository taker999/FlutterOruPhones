class Brand {
  final String brandName;
  final String imagePath;

  Brand({required this.brandName, required this.imagePath});

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      brandName: map['make'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'make': brandName,
      'imagePath': imagePath,
    };
  }
}
