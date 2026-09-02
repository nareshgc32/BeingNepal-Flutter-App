import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/hotel_model.dart';

class ApiService {
  static const String baseUrl = 'https://beingnepal.com/api';

  static Future<List<Hotel>> fetchHotels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/hotels'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Hotel> hotels = [];

        if (jsonData is List) {
          hotels = jsonData
              .map((hotel) => Hotel.fromJson(hotel as Map<String, dynamic>))
              .toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          hotels = (jsonData['data'] as List)
              .map((hotel) => Hotel.fromJson(hotel as Map<String, dynamic>))
              .toList();
        } else if (jsonData is Map && jsonData.containsKey('hotels')) {
          hotels = (jsonData['hotels'] as List)
              .map((hotel) => Hotel.fromJson(hotel as Map<String, dynamic>))
              .toList();
        }

        // If API returns empty or no hotels, return sample data
        if (hotels.isEmpty) {
          return _getSampleHotels();
        }

        return hotels;
      } else {
        return _getSampleHotels();
      }
    } catch (e) {
      print('Error fetching hotels: $e');
      return _getSampleHotels();
    }
  }

  static Future<Hotel?> fetchHotelDetails(String hotelId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/hotels/$hotelId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Map<String, dynamic> hotelData;

        if (jsonData is Map && jsonData.containsKey('data')) {
          hotelData = jsonData['data'] as Map<String, dynamic>;
        } else {
          hotelData = jsonData as Map<String, dynamic>;
        }

        return Hotel.fromJson(hotelData);
      }
      return null;
    } catch (e) {
      print('Error fetching hotel details: $e');
      return null;
    }
  }

  static Future<List<Hotel>> searchHotels(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/hotels/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Hotel> hotels = [];

        if (jsonData is List) {
          hotels = jsonData
              .map((hotel) => Hotel.fromJson(hotel as Map<String, dynamic>))
              .toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          hotels = (jsonData['data'] as List)
              .map((hotel) => Hotel.fromJson(hotel as Map<String, dynamic>))
              .toList();
        }

        return hotels;
      }
      return [];
    } catch (e) {
      print('Error searching hotels: $e');
      return [];
    }
  }

  static List<Hotel> _getSampleHotels() {
    return [
      Hotel(
        id: '1',
        name: 'Kathmandu Luxury Resort',
        description: 'Experience luxury in the heart of Kathmandu with world-class amenities and exceptional service.',
        rating: 4.8,
        reviews: 245,
        price: 15000,
        location: 'Kathmandu, Nepal',
        image: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&h=300&fit=crop',
        amenities: ['Wi-Fi', 'Pool', 'Gym', 'Restaurant', 'Spa', 'AC'],
        phoneNumber: '+977-1-4001234',
        email: 'info@kathmandu-luxury.com',
        latitude: 27.7172,
        longitude: 85.3240,
      ),
      Hotel(
        id: '2',
        name: 'Pokhara Lakeside Hotel',
        description: 'Beautiful lakeside hotel with stunning mountain views and comfortable rooms.',
        rating: 4.6,
        reviews: 189,
        price: 12000,
        location: 'Pokhara, Nepal',
        image: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=500&h=300&fit=crop',
        amenities: ['Lake View', 'Restaurant', 'Bar', 'Garden', 'Wi-Fi', 'Parking'],
        phoneNumber: '+977-61-465432',
        email: 'contact@pokhara-lakeside.com',
        latitude: 28.2096,
        longitude: 83.9856,
      ),
      Hotel(
        id: '3',
        name: 'Himalayan Mountain Lodge',
        description: 'Cozy mountain lodge perfect for trekkers with authentic Nepali hospitality.',
        rating: 4.7,
        reviews: 312,
        price: 8500,
        location: 'Namche, Nepal',
        image: 'https://images.unsplash.com/photo-1551632786-de41ec6a05ae?w=500&h=300&fit=crop',
        amenities: ['Fireplace', 'Heating', 'Traditional Decor', 'Restaurant', 'Trek Info'],
        phoneNumber: '+977-369-440000',
        email: 'lodge@himalayan.com',
        latitude: 27.7917,
        longitude: 86.7125,
      ),
      Hotel(
        id: '4',
        name: 'Bhaktapur Heritage Hotel',
        description: 'Historic hotel showcasing traditional Nepali architecture and culture.',
        rating: 4.5,
        reviews: 156,
        price: 10000,
        location: 'Bhaktapur, Nepal',
        image: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500&h=300&fit=crop',
        amenities: ['Heritage Building', 'Courtyard', 'Cultural Tour', 'Restaurant', 'Wi-Fi'],
        phoneNumber: '+977-1-6612345',
        email: 'heritage@bhaktapur.com',
        latitude: 27.6722,
        longitude: 85.8292,
      ),
      Hotel(
        id: '5',
        name: 'Chitwan Jungle Resort',
        description: 'Adventure resort in the heart of nature with wildlife safari experiences.',
        rating: 4.9,
        reviews: 425,
        price: 18000,
        location: 'Chitwan, Nepal',
        image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop',
        amenities: ['Safari', 'Pool', 'Jungle View', 'Restaurant', 'Spa', 'Guide Service'],
        phoneNumber: '+977-56-520100',
        email: 'safari@chitwan-resort.com',
        latitude: 27.5500,
        longitude: 84.3092,
      ),
      Hotel(
        id: '6',
        name: 'Janakpur Cultural Hotel',
        description: 'Experience authentic Mithila art and local culture in this unique boutique hotel.',
        rating: 4.4,
        reviews: 98,
        price: 7500,
        location: 'Janakpur, Nepal',
        image: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=500&h=300&fit=crop',
        amenities: ['Art Gallery', 'Cultural Programs', 'Local Cuisine', 'Workshop', 'Wi-Fi'],
        phoneNumber: '+977-41-520256',
        email: 'culture@janakpur-hotel.com',
        latitude: 26.9124,
        longitude: 85.9254,
      ),
    ];
  }
}
