import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../services/networking.dart';
import '../utilities/constants.dart';
import '../utilities/time.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> weatherDate;

  const LocationScreen({super.key, required this.weatherDate});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic>? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
              'https://source.unsplash.com/random/?nature,day',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedCountry = null;
                      });
                    },
                    icon: const Icon(
                      Icons.location_on,
                      size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (Country country) async {
                          NetworkHelper network = NetworkHelper(
                              url:
                                  'https://api.openweathermap.org/data/2.5/weather?q=${country.name}&appid=$kApiKey');
                          selectedCountry = await network.getData();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Row(
                children: [
                  Text(
                    selectedCountry == null
                        ? ((widget.weatherDate['main']['temp'] - 272.15)
                                .round())
                            .toString()
                        : ((selectedCountry!['main']['temp'] - 272.15).round())
                            .toString(),
                    style: const TextStyle(
                        fontSize: 128, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '°',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 64,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'now',
                          style: TextStyle(
                            letterSpacing: 12,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Grab Sunglasses',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                "${selectedCountry == null ? widget.weatherDate['name'] : selectedCountry!['name']}'s weather state",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff7CCCC9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      CurrentTime.getCurrentTime(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sunny,
                          size: 32,
                          color: Colors.white,
                        ),
                        SizedBox(width: 24),
                        Text(
                          'Before sunrise',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
