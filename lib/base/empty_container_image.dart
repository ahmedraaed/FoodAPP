import 'package:flutter/material.dart';
import 'package:foodapp/widgets/custom_text_small.dart';

class EmptyScreen extends StatelessWidget {
  String text;
  String pathImae;

   EmptyScreen({Key? key,required this.text,this.pathImae="assats/image/empty_cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          pathImae,
          height: MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width*0.5,
        ),
        Text(text,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),),
        
      ],
    );
  }
}
