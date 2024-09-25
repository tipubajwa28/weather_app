import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/HourlyForcastItem.dart';
import 'package:weather_app/InfoItem.dart';
import 'package:weather_app/secret.dart';
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}
var city;
class _WeatherScreenState extends State<WeatherScreen> {
    bool isNightTime() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    return (currentHour >= 18 || currentHour < 6);  // Night time is after 6:00 PM or before 6:00 AM
}
Future<Map<String,dynamic>> GetWeather() async {
  try {
    city = 'Lahore';
    // Make the GET request
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openkey'),
    );
    // Decode the response body
    final data = jsonDecode(response.body);

    // Check if the API response status is successful
    if (data['cod'] != '200') {
      throw Exception('Unexpected Error: ${data['message']}');
    }
    return data;
    // Access the temperature (Make sure 'list' and 'main' exist)
  } catch (e) {
    // Catch and print any errors
    throw 'Error occurred: $e';
  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          ),
          actions:  [
           IconButton(onPressed: (){
            setState(() {
              
            });
           }, 
           icon: const Icon(Icons.refresh),iconSize: 23,)
          ],
      ),
      
      body: FutureBuilder(
        future: GetWeather(),
        builder: (context,snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 80, 92, 100),
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data=snapshot.data!;
          final curentTemp=(data['list'][0]['main']['temp']);
          int temp = (curentTemp.round()-273);
          final sky=data['list'][0]['weather'][0]['main'];
          final presure=data['list'][0]['main']['pressure'];
          final humidity=data['list'][0]['main']['humidity'];
          final windspeed=data['list'][0]['wind']['speed'];
          //int temp=int.parse(curentTemp);
          return Padding(
            padding:  const EdgeInsets.all(16),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                  height: 10,
                  child: Icon(Icons.location_on,),
                ),
                 Text(city,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 6,),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter:ImageFilter.blur(sigmaX:6 ,sigmaY:6 , ),
                      child:    Padding(
                        padding:  const EdgeInsets.all(16.0),
                        child: Column(children: [
                        Text('$temp° C',
                        style:  const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        ), const SizedBox(height: 8,),
                         Icon(data['list'][0]['weather'][0]['main']=='Clouds' || data['list'][0]['weather'][0]['main']=='Rain'? 
                      (isNightTime()?Icons.nights_stay :Icons.cloud):
                      (isNightTime() ? Icons.nightlight_round_sharp : Icons.sunny),
                         size: 40,),
                         const SizedBox(height: 8,),
                         Text(sky,
                        style: const TextStyle(fontSize: 16),
                        ),
                        ],),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              //Weather forecast TEXT
              const Text("Weather Forecast",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8,),
              //second part------------------------------------

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder:(context,index){
                      final time =DateFormat.jm().format(DateTime.parse(data['list'][index+1]['dt_txt'].toString()));
                      return 
                      HourlyForcastItem(
                      icon:data['list'][index+1]['weather'][0]['main']=='Clouds' || data['list'][index+1]['weather'][0]['main']=='Rain'?Icons.cloud:Icons.sunny,
                      temperature:data['list'][index+1]['main']['temp'].toString(),
                      timee:time,
                      )
                      ;
                  }),
                ),
            //third part
              const SizedBox(height: 20,),
              const Text("Aditional Information",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Infoitems(
                  icon: Icons.cloud,
                  lable: 'Humidity',
                  val: humidity.toString(),
                ),
                Infoitems(              
                  icon: Icons.air,
                  lable: 'Air Speed',
                  val: windspeed.toString(),),
                Infoitems(              
                  icon: Icons.beach_access,
                  lable: 'presure',
                  val: presure.toString(),),
              ],
          
            ),
            
            ],),
          );
        },
      ),
    );
  }
}

