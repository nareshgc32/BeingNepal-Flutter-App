import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/hotel_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/hotel_card.dart';

void main() {
  runApp(const BeingNepalApp());
}

class BeingNepalApp extends StatelessWidget {
  const BeingNepalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HotelProvider()..fetchHotels(),
      child: MaterialApp(
        title: 'Being Nepal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        home: const HotelListPage(),
      ),
    );
  }
}

class HotelListPage extends StatefulWidget {
  const HotelListPage({super.key});

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Being Nepal Hotels'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by hotel name or location',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: provider.searchHotels,
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? ListView.builder(
                    itemCount: 4,
                    itemBuilder: (_, __) => const HotelCardShimmer(),
                  )
                : provider.hotels.isEmpty
                    ? const Center(
                        child: Text('No hotels found'),
                      )
                    : ListView.builder(
                        itemCount: provider.hotels.length,
                        itemBuilder: (context, index) {
                          final hotel = provider.hotels[index];
                          return HotelCard(
                            hotel: hotel,
                            isFavorite: provider.isFavorite(hotel.id),
                            onTap: () {},
                            onFavoriteTap: () {
                              context.read<HotelProvider>().toggleFavorite(hotel);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
