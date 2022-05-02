// ignore_for_file: prefer _const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingeniousmind/controllers/MainController.dart';
import 'package:ingeniousmind/models/MainListResponse.dart';
import 'package:ingeniousmind/ui/MapScreenUI.dart';
import 'package:ingeniousmind/utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenUI extends StatefulWidget {
  @override
  _MainScreenUIState createState() => _MainScreenUIState();
}

class _MainScreenUIState extends State<MainScreenUI> {

  late SharedPreferences sharedPreferences;
  MainController mainController = Get.put(MainController());
  List<String> keyList = [];

  @override
  void initState() {
    super.initState();
    //checkInternet();
    callApi();
  }




/*
  checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult  ::  $connectivityResult");

    if (connectivityResult == ConnectivityResult.mobile) {
      callApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      callApi();
    }
    else{
      print("---No Internet---");
      prefInit();
    }
  }
*/


  callApi() async {

    mainController.mainListApi().then((value) {
      mainController.apiList = value;
      prefInit();
      value.forEach((key,value){
        //print("KEY  ::  $key");
        keyList.add(key);
      });

    });
  }

  prefInit() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if(mainController.apiList != null && mainController.apiList != "" ){
      print("NOT NULL");
      sharedPreferences.setString("dataList", json.encode(mainController.apiList));
      sharedPreferences.setStringList("keyList", keyList);
    }

    if(mainController.apiList == null && mainController.apiList == ""){
      print("NULL");
      mainController.apiList = json.decode(sharedPreferences.getString("dataList") ?? "");
      keyList = sharedPreferences.getStringList("keyList") ?? [];
      setState(() {});
    }
    mainController.isDataLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("Data List"),
          centerTitle: true,
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
        body: GetBuilder(
          init: MainController(),
          builder: (MainController controller) {
            return controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : controller.apiList.length < 0
                  ? Center(child: Text("No Data Found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black38),))
                  : ListView.builder(
                    itemCount: controller.apiList.length,
                    itemBuilder: (context, index) {
                    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(()=> MapScreenUI(lat: mainController.apiList[keyList[index]]['lat'],long: mainController.apiList[keyList[index]]['lon'],) );
                      },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(mainController.apiList[keyList[index]]['name'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                                Text(mainController.apiList[keyList[index]]['icao'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black38),),
                              ],),

                              SizedBox(height: 5,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text("${mainController.apiList[keyList[index]]["city"]} / ${mainController.apiList[keyList[index]]["city"] }",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                                Text(mainController.apiList[keyList[index]]["country"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black38),),
                              ],),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

      ),
    );
  }
}

class Name {
  final List<MainListResponse> userList;
  Name({required this.userList});
}

class Data{
  String? icao;
  String? iata;
  String? name;
  String? city;
  String? state;
  String? country;
  int? elevation;
  double? lat;
  double? lon;
  String? tz;

  Data({this.icao, this.iata, this.name, this.city, this.state, this.country,
      this.elevation, this.lat, this.lon, this.tz});
}