class Hotel {
  final String id;
  final String name;
  final String description;
  final double rating;
  final int reviews;
  final double price;
  final String location;
  final String image;
  final List<String> amenities;
  final String phoneNumber;
  final String email;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.location,
    required this.image,
    required this.amenities,
    required this.phoneNumber,
    required this.email,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Hotel',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      location: json['location'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/400x300?text=Hotel',
      amenities: List<String>.from(json['amenities'] ?? []),
      phoneNumber: json['phone'] ?? '',
      email: json['email'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'reviews': reviews,
      'price': price,
      'location': location,
      'image': image,
      'amenities': amenities,
      'phone': phoneNumber,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorite': isFavorite,
    };
  }

  Hotel copyWith({
    String? id,
    String? name,
    String? description,
    double? rating,
    int? reviews,
    double? price,
    String? location,
    String? image,
    List<String>? amenities,
    String? phoneNumber,
    String? email,
    double? latitude,
    double? longitude,
    bool? isFavorite,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      location: location ?? this.location,
      image: image ?? this.image,
      amenities: amenities ?? this.amenities,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
