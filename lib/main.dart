import 'package:flutter/material.dart';
import 'package:weather_app/first_screen.dart';

void main() {
  runApp(const WeatherApp());
}
class  WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          
        )
      ),
      debugShowCheckedModeBanner: false,
      home:  const WeatherScreen(),
    );
  }
}

