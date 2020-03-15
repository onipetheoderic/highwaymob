import 'package:flutter/material.dart';
import 'forgotscreen.dart';
import 'dashboardscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'dart:async';
import 'components/screenArguments.dart';
import 'package:flutter/services.dart';


class CompletedDatasheet extends StatefulWidget {
  static const routeName = '/datasheet_component';
 
  @override
  _DatasheetComponentState createState() => _DatasheetComponentState();
}

class _DatasheetComponentState extends State<CompletedDatasheet> {
  
  var id;


  
  @override
  Widget build(BuildContext context){
    
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Completed Inspection"),
        backgroundColor: Colors.greenAccent[700],
      ),
      // sexyCard("theoderic", "is the don in the Hood"),
      body: Center(
        child:Column(
        children:[
          sexyCard("Create Completed Road Datasheet", "Create New Completed Road Datasheet", "create"),
          sexyCard("Create Completed Bridge Datasheet", "Create A New Completed Datasheet", "create"),
          sexyCard("View Completed Road Datasheets", "View All Completed Road Datasheet", "One"),
          sexyCard("View Completed Bridge Datasheet", "View All Completed Bridge Datasheet", "Two"),
    
          ] )
      )
    );
  }

Widget sexyCard(String title, String description, String id){
  return(
      new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context,'/completed_road');
        },
      child: Padding(padding: const EdgeInsets.all(16.0),
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
                      child: myDetailContainer(title, description, id),
                    ),
                    Container(
                      width:250,
                      height:150,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image:  id=="create"? AssetImage('assets/images/view.png'):AssetImage('assets/images/edit.png'),
                          )
                      )
                    ),
                  ],
                )
              )
            )
          )
        ),
      )
   
  );
}


  Widget myDetailContainer(String title, String description, String id){
    if(title!=null && description!=null && id!=null){
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
    else return null;
    
  }
}
