import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    title: "Weather app",
    home:Home() ,
  )
);
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var currently;
  var description;
  var humidity;
  var wind_speed;

  Future getWeather() async{
    http.Response response = await http.get("https://api.openweathermap.org/data/2.5/weather?q=Kolkata&units=metric&appid=5ab2006794fd7bcfd74495296787b0d0");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.wind_speed = result['wind']['speed'];
    });
  }

  @override void initState ()
  {
    super.initState();
    this.getWeather();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Padding(
                 padding: EdgeInsets.only(bottom: 10.0),
                 child: Text(
                   "Currently in Kolkata",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ),
                Text(
                  temp != null ? temp.toString()+"\u00B0c":"Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing:Text(temp != null ? temp.toString()+"\u00B0c":"Loading") ,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing:Text(description!=null ? description.toString():"Loading") ,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing:Text(humidity!=null? humidity.toString():"Loading") ,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed "),
                    trailing:Text(wind_speed!=null? wind_speed.toString()+" km/h":"Loading") ,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
