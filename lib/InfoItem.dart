import 'package:flutter/material.dart';
class Infoitems extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String val;
  const Infoitems({
    super.key,
    required this.icon,
    required this.lable,
    required this.val,

  });

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      Icon(
      icon,
      size: 25,
      ),
      const SizedBox(height: 6,),
      Text(lable,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold
      ),),
      const SizedBox(height: 6,),
      Text(val,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
      )
    
    ],);
  }
}
