import 'package:covid_self_quarantine/Api.dart';
import 'package:covid_self_quarantine/Utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class CheckInWidget extends StatefulWidget {
  @override
  _CheckInWidgetState createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  final storage = new FlutterSecureStorage();

  bool isGPSEnabled = false;
  bool isGranted = false;

  double lat;
  double lng;

  Api api = Api();
  Utils utils = Utils();

  String currentLocationName = '';
  DateTime now = DateTime.now();

  Future getCurrentPlaceName() async {
    try {
      Response rs = await api.getCheckInPlace(lat, lng);
      if (rs.statusCode == 200) {
        setState(() {
          currentLocationName = rs.data['display_name'];
        });
      } else {
        print('Get place name error');
      }
    } catch (error) {
      print(error);
    }
  }

  Future saveTracking() async {
    try {
      String _token = await storage.read(key: "token");
      Response rs = await api.saveTracking(lat, lng, currentLocationName, _token );
      if (rs.statusCode == 200) {
        utils.successAlert();
      } else {
        utils.errorAlert();
      }
    } catch (error) {
      utils.errorAlert();
      print(error);
    }
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      setState(() {
        isGPSEnabled = true;
      });
    }


    permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
    setState(() {
      isGranted = true;
    });
  }
    print('Permission: $permission');

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          isGPSEnabled = false;
        });
      }
    }

    if (isGPSEnabled && isGranted) {
      Position position = await Geolocator.getCurrentPosition();
      print(position);

      if (position.longitude != null && position.latitude != null) {
        setState(() {
          lat = position.latitude;
          lng = position.longitude;
        });

        getCurrentPlaceName();
      }
    } else {
      print('====================');
      print('No permission found');
      print('====================');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // height: 100,
      decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.purple, width: 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Check-In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
              ),

              IconButton(icon: Icon(Icons.my_location, color: Colors.pink,), onPressed: () {
                _determinePosition();
              },)
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Current time: ${utils.toThaiDate(now)} ${now.hour}:${now.minute}'),
                  lat != null && lng != null ? Text(
                    '${currentLocationName ?? 'ไม่พบชื่อพิกัด'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ) :Text('กรุณาเปิด GPS', style: TextStyle(color: Colors.red)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (lat != null && lng != null && currentLocationName != null) {
                    saveTracking();
                  }
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.purple, width: 1),
                    ),
                    child: Icon(
                      Icons.add_location_alt,
                      size: 55,
                      color: Colors.purple,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
