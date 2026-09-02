import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/hotel_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const BeingNepalApp());
}

class BeingNepalApp extends StatelessWidget {
  const BeingNepalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HotelProvider(),
      child: MaterialApp(
        title: 'Being Nepal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
