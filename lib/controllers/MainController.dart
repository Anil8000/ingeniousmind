import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController{

    bool isLoading = true;
    dynamic apiList;

    Future<dynamic> mainListApi() async {
        http.Response response = await http.get(Uri.parse("https://raw.githubusercontent.com/mwgg/Airports/master/airports.json")).timeout(Duration(seconds: 10),onTimeout: (){
            throw("something went wrong");
        });
        if(response.statusCode == 200){
            if(response.body != null){
                apiList = json.decode(response.body);
                isDataLoading(false);
                return apiList;
            }
        }

       /* var request = http.Request('GET', Uri.parse('https://raw.githubusercontent.com/mwgg/Airports/master/airports.json'));
        http.StreamedResponse response = await request.send();
        //print(await response.stream.bytesToString());
        if (response.statusCode == 200) {

            return json.decode(await response.stream.bytesToString());
        }
        else {
            print(response.reasonPhrase);
        }*/




    }

    void isDataLoading(bool isLoading){
        this.isLoading = isLoading;
        update();
    }

}