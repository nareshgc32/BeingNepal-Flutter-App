import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hotel_provider.dart';
import '../widgets/hotel_card.dart';
import 'hotel_detail_screen.dart';

class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Being Nepal Hotels')),
      body: Consumer<HotelProvider>(
        builder: (context, hotelProvider, _) {
          if (hotelProvider.isLoading && hotelProvider.hotels.isEmpty) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => const HotelCardShimmer(),
            );
          }

          if (hotelProvider.hotels.isEmpty) {
            return const Center(child: Text('No hotels found'));
          }

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
