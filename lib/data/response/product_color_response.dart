class ProductColorResponse {
  final String color;
  final bool isSelected;

  ProductColorResponse({
    required this.color,
    required this.isSelected,
  });

  factory ProductColorResponse.fromFirestore(String e) {
    return ProductColorResponse(
      color: e,
      isSelected: false,
    );
  }
}
