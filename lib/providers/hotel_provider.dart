import 'package:flutter/material.dart';
import '../models/hotel_model.dart';
import '../services/api_service.dart';

class HotelProvider extends ChangeNotifier {
  List<Hotel> _hotels = [];
  List<Hotel> _filteredHotels = [];
  final List<Hotel> _favorites = [];
  bool _isLoading = false;
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 100000;
  double _minRating = 0;

  // Getters
  List<Hotel> get hotels => _filteredHotels;
  List<Hotel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  double get minRating => _minRating;

  // Initialize and fetch hotels
  Future<void> fetchHotels() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _hotels = await ApiService.fetchHotels();
      _filteredHotels = List.from(_hotels);
    } catch (e) {
      debugPrint('Error in provider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search hotels
  Future<void> searchHotels(String query) async {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredHotels = List.from(_hotels);
    } else {
      _isLoading = true;
      notifyListeners();
      
      try {
        final results = await ApiService.searchHotels(query);
        _filteredHotels = results.isEmpty
            ? _hotels
                .where((hotel) =>
                    hotel.name.toLowerCase().contains(query.toLowerCase()) ||
                    hotel.location.toLowerCase().contains(query.toLowerCase()))
                .toList()
            : results;
      } catch (e) {
        debugPrint('Search error: $e');
        _filteredHotels = _hotels
            .where((hotel) =>
                hotel.name.toLowerCase().contains(query.toLowerCase()) ||
                hotel.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
    
    notifyListeners();
  }

  // Filter hotels by price and rating
  void filterHotels({double? minPrice, double? maxPrice, double? minRating}) {
    if (minPrice != null) _minPrice = minPrice;
    if (maxPrice != null) _maxPrice = maxPrice;
    if (minRating != null) _minRating = minRating;

    _filteredHotels = _hotels
        .where((hotel) =>
            hotel.price >= _minPrice &&
            hotel.price <= _maxPrice &&
            hotel.rating >= _minRating)
        .toList();

    notifyListeners();
  }

  // Reset filters
  void resetFilters() {
    _minPrice = 0;
    _maxPrice = 100000;
    _minRating = 0;
    _searchQuery = '';
    _filteredHotels = List.from(_hotels);
    notifyListeners();
  }

  // Toggle favorite
  void toggleFavorite(Hotel hotel) {
    final index = _hotels.indexWhere((h) => h.id == hotel.id);
    if (index != -1) {
      final updatedHotel = _hotels[index].copyWith(isFavorite: !_hotels[index].isFavorite);
      _hotels[index] = updatedHotel;

      if (updatedHotel.isFavorite) {
        if (!_favorites.any((h) => h.id == hotel.id)) {
          _favorites.add(updatedHotel);
        }
      } else {
        _favorites.removeWhere((h) => h.id == hotel.id);
      }

      notifyListeners();
    }
  }

  // Check if hotel is favorite
  bool isFavorite(String hotelId) {
    return _favorites.any((hotel) => hotel.id == hotelId);
  }
}
