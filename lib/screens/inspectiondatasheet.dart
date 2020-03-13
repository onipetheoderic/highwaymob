import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Datasheet extends StatefulWidget {
  @override
  _DatasheetState createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects You are Assigned To"),
        backgroundColor: Colors.greenAccent[700],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget> [
          Padding(padding: EdgeInsets.only(top:20, bottom:20),
          child:Center(
            child:Text(
              "Select the Project You want", style: TextStyle(fontSize:20, fontFamily:'Audiowide')
            ),
          ),),
          sexyCard("theoderic", "is the don in the Hood"),
         
          
         
        ]
      )
    );
  }

Widget sexyCard(String title, String description){
  return(
     Padding(padding: const EdgeInsets.all(16.0),
          child: Container(
            child: FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: myDetailContainer(title, description),
                    ),
                    Container(
                      width:250,
                      height:150,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image: NetworkImage("https://png.pngtree.com/png-vector/20190511/ourmid/pngtree-vector-road-bridge-icon-png-image_1029283.jpg"))
                      )
                    ),
                  ],
                )
              )
            )
          )
        )
  );
}


  Widget myDetailContainer(String title, String description){
    return(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right:10, left:20),
            child: Center(child: Text(title, style:TextStyle(fontSize:20, fontFamily:'Candara')),)
          ),
           Padding(
            padding: EdgeInsets.only(right:10, left:20),
            child: Center(child: Text(description, style:TextStyle(fontSize:16, fontFamily:'Candara')))
          ),
          
          
        ],
        )
    );
  }
}