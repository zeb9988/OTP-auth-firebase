import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _mapStyle;

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((value) {
      _mapStyle = value;
    });
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 0,
            bottom: 0,
            right: 0,
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                myMapController!.setMapStyle(_mapStyle);
              },
            ),
          ),
          buildProfile(),
          _buildStyledTextField()
        ],
      ),
    );
  }
}

Widget buildProfile() {
  return Positioned(
    top: 60,
    left: 20,
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.yellow,
            radius: 30,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Good Morning,   ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextSpan(
                        text: 'Zohaib Mustafa',
                        style: TextStyle(color: Colors.green, fontSize: 18))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Where Are You Going....',
                  style: TextStyle(color: Colors.black, fontSize: 14))
            ],
          )
        ],
      ),
    ),
  );
}

Widget _buildStyledTextField() {
  return Positioned(
    top: 160,
    left: 0,
    right: 0,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.green), // Change text color to green
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.green, // Change icon color to green
          ),
          hintText: 'Search...', // Use hintText instead of labelText
          hintStyle: TextStyle(
            color: Colors.grey, // Change hint text color to grey
          ),
          border: InputBorder.none, // Remove the border
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    ),
  );
}
