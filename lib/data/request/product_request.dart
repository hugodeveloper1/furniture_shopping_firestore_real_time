class ProductResquest {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double starts;
  final List<String> colors;

  ProductResquest({
    required this.name,
    this.description =
        'Minimal Sofa is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
    required this.imageUrl,
    this.price = 50.99,
    this.starts = 4.5,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'starts': starts,
      'colors': colors.map((e) => e.toString()).toList(),
      'name': name,
    };
  }
}
