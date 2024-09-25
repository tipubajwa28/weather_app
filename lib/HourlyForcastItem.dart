import 'package:flutter/material.dart';
class HourlyForcastItem extends StatelessWidget {
  final String timee;
  final IconData icon;
  final String temperature;
  const HourlyForcastItem({
    super.key,
    required this.icon,
    required this.temperature,
    required this.timee,
  
  
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 6,
                  child:Container(
                    width: 90,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child:  Column(children: [
                      Text(timee,//time
                      maxLines: 1,
                      overflow: TextOverflow.clip ,
                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                      ),
                      const SizedBox(height: 8,),
                      Icon(icon,size: 30,),
                      const SizedBox(height: 8,),
                      Text(temperature,//weather
                      style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                      ),
                    
                    ],),
                  ),
                );
  }
}
