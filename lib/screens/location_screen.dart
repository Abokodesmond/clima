import 'dart:convert';

import 'package:clima/screens/city_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';



class LocationScreen extends StatefulWidget {
  
  const LocationScreen({required  this.locationWeather} );
final locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather =WeatherModel();
 int  ? temperature;
  String ?weatherIcon;
  String ?cityName;
  String ? weatherMessage;
  
  
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.locationWeather);
    updateUI(widget.locationWeather); 
  }
  void updateUI (dynamic weatherData){
setState(() {
  if(weatherData==null){
    temperature=0;
    weatherIcon='Error';
    weatherMessage='Unable to get weather data';
    cityName='';
    return;
     
  }
  double temp= weatherData['main']['temp'];
 
  var condition = weatherData['weather'][0]['id'];
 cityName = weatherData['name'];
weatherIcon= weather.getWeatherIcon(condition  );
weatherMessage= weather.getMessage(temp.toInt());
 temperature=temp.toInt();
 
});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
       
        constraints:  BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async{
                      
                      var weatherData =await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: ()async {
                   var typedName= await   Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(typedName);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Text(
                "$weatherMessage in $cityName!",
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

