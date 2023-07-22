import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/utilities/constants.dart';

import '../services/networking.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getCurrentLocation() async {
    try {
      Location location = Location();
      final position = await location.getLocation();
      var weatherDate = await NetworkHelper(
              url:
                  'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$kApiKey')
          .getData();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(
              weatherDate: weatherDate,
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
