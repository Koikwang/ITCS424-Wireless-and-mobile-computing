import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class FindShop extends StatefulWidget {
  // Define props here...
  const FindShop({super.key});

  @override
  State<FindShop> createState() => _FindShopState();
}

class _FindShopState extends State<FindShop> {
  late GoogleMapController _mapController;

  LatLng _currentLocation =
      const LatLng(13.7563, 100.5018); // Victory Monument, Bangkok, Thailand

  late Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _markNearestShop();
    _mapController = controller;
  }

  void _markNearestShop() async {
    try {
      setState(() {
        _markers = {};
      });

      final dio = Dio();
      final params = {
        'location':
            '${_currentLocation.latitude},${_currentLocation.longitude}',
        'radius': 10000,
        'type': 'store',
        'keyword': 'kpop',
        'key': dotenv.env['GOOGLE_MAP_API_KEY']
      };
      final response = await dio.get(dotenv.env['GOOGLE_PLACE_API_ENDPOINT']!,
          queryParameters: params);

      if (response.data['status'] != 'OK') {
        throw Exception(response.data['status']);
      }

      final results = response.data['results'];
      for (int i = 0; i < results.length; i++) {
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(results[i]['geometry']['location']['lat'],
                results[i]['geometry']['location']['lng']),
            infoWindow: InfoWindow(
              title: results[i]['name'],
              snippet: results[i]['vicinity'],
            ),
          ));
        });
      }
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Kpop Shop'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 12.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Geolocator.requestPermission();
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          setState(() {
            _currentLocation = LatLng(position.latitude, position.longitude);
          });
          _markNearestShop();
          _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              _currentLocation,
              12.0,
            ),
          );
        },
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
