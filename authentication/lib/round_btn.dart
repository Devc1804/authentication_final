import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{
  const RoundButton(this.text,this.onValidate,{super.key});

  final String text;
  final  onValidate;
  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      width:MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10)
        ),
        
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
            onPressed: () {
              onValidate();
            },
            child:  Text(text,style: TextStyle(color: Colors.white),),
            ),
    );
  }
}