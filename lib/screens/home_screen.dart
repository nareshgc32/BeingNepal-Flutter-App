import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hotel_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/hotel_card.dart';
import 'hotel_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HotelProvider>().fetchHotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Being Nepal Hotels'),
      ),
      body: Consumer<HotelProvider>(
        builder: (context, hotelProvider, child) {
          if (hotelProvider.isLoading && hotelProvider.hotels.isEmpty) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => const HotelCardShimmer(),
            );
          }

          if (hotelProvider.hotels.isEmpty) {
            return const Center(
              child: Text(
                'No hotels found.',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: hotelProvider.fetchHotels,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: hotelProvider.hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotelProvider.hotels[index];

                return HotelCard(
                  hotel: hotel,
                  isFavorite: hotelProvider.isFavorite(hotel.id),
                  onFavoriteTap: () => hotelProvider.toggleFavorite(hotel),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HotelDetailScreen(hotel: hotel),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
