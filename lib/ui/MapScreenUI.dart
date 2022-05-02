// ignore_for_file: prefer_final_fields, unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ingeniousmind/utils/AppColors.dart';


class MapScreenUI extends StatefulWidget {
  var lat;
  var long;
  MapScreenUI({this.lat,this.long});

  @override
  State<MapScreenUI> createState() => _MapScreenUIState();
}

class _MapScreenUIState extends State<MapScreenUI> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marker ={};
  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat,widget.long),
      zoom: 15,
    );

  }

    void onMapCreated(GoogleMapController googleMapController){
      setState(() {
        _marker.add(Marker(markerId: MarkerId("id-1"),position: LatLng(widget.lat,widget.long)),);
      });
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_outlined)),
            title: Text("Location"),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor,
                      Colors.black,
                    ]),
              ),
            ),
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            markers: _marker,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: onMapCreated,
          ),
        ));
  }
}

