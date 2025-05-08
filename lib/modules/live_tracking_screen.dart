import 'dart:async';
import 'dart:convert';

import 'package:ahmoma_app/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polyPoints = [];
  LatLng sourceLocation = LatLng(20.987011, 105.796379);
  LatLng destinationLocation = LatLng(20.990163, 105.790496);

  // Add custom icon
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  void setCustomIcon() async {
    try {
      final iconsResult = await Future.wait([
        BitmapDescriptor.asset(
          ImageConfiguration(size: Size(15, 18)),
          "assets/images/gps.png",
        ),
        BitmapDescriptor.asset(
          ImageConfiguration(size: Size(15, 18)),
          "assets/images/gps.png",
        ),
      ]);

      setState(() {
        sourceIcon = iconsResult[0];
        destinationIcon = iconsResult[1];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    setCustomIcon();
    // getPolyPoints();
    _getRoute(sourceLocation, destinationLocation);
    super.initState();
  }

  Future<void> _getRoute(LatLng origin, LatLng destination) async {
    final String apiKey = AppConstants.googleApiKey;
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      if (data['routes'].isNotEmpty) {
        // final encodedPolyline = data['routes'][0]['overview_polyline']['points'];
        // final points = _decodePolyline(encodedPolyline);
        // _showRoute(points);

        print(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
            icon: sourceIcon,
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: destinationLocation,
            icon: destinationIcon,
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polyPoints,
            width: 6,
            color: Colors.orange,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  void getPolyPoints() async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: AppConstants.googleApiKey,
        request: PolylineRequest(
          origin: PointLatLng(
            sourceLocation.latitude,
            sourceLocation.longitude,
          ),
          destination: PointLatLng(
            destinationLocation.latitude,
            destinationLocation.longitude,
          ),
          mode: TravelMode.driving,
          optimizeWaypoints: true,
          wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
        ),
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polyPoints =
              result.points
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList();
        });
      }

      print(result);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
