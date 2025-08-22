import 'package:flutter/material.dart';

class WeatherAlertsScreen extends StatelessWidget {
  const WeatherAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Alerts')),
      body: Center(
        child: Text(
          'No weather alerts at this time.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
