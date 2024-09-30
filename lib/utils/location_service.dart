import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
 static Future getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever.
      _showOpenAppSettingsDialog();
      return;
    }
    // When permissions are granted, get the current position.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    getAddressFromLatLng(position).then((val){
      if(val!=null){
        print(val);
        SessionManager.setAddress = val;
      }
    });
    SessionManager.setLat = position.latitude.toString();
    SessionManager.setLng = position.longitude.toString();

    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    return position;
  }

 static void _showOpenAppSettingsDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permissions'),
          content: Text(
              'Location permissions are permanently denied. Please enable them in the app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

 static Future getAddressFromLatLng(Position position) async {
   try {
     String _currentAddress = '';
     List<Placemark> placemarks =
     await placemarkFromCoordinates(position.latitude, position.longitude);
     Placemark place = placemarks[0];
       _currentAddress =
       "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
       return _currentAddress;
   } catch (e) {
     print(e);
   }
 }

}