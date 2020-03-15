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


class CompletedRoad extends StatefulWidget {
  static const routeName = '/datasheet_component';
 
  @override
  _DatasheetComponentState createState() => _DatasheetComponentState();
}

class _DatasheetComponentState extends State<CompletedRoad> {
  
  var id;

  _saveChanges(String val, String id) async{
    print("from the function, $val, $id");
    print(val.length);  
    if(val.length>=2){
      final storage = new FlutterSecureStorage();
      final value = await storage.read(key: 'token');
      print("DDDDDDDDDD$value");
      final bearer = "Bearer "+value;
      var data = await http.post("http://localhost:5000/api/edit_single_component", body: {'component_id': id, 'component_score': val}, headers: {"Accept": "application/json", "authorization":bearer});
      var jsonData = json.decode(data.body);
      print("YYYYYYYYYYYY $jsonData");
    }
  }

  Future<List<Component>> _getContracts() async{
    final storage = new FlutterSecureStorage();
    final value = await storage.read(key: 'token');
    print("DDDDDDDDDD$value");
    final bearer = "Bearer "+value;
    var data = await http.get("http://localhost:5000/create_completed_datasheet/completed_road_datasheet/completed_road", headers: {"Accept": "application/json", "authorization":bearer});
    
    var jsonData = json.decode(data.body);
    print("XXXXXXXXXXXXXXXX$jsonData"); 
    List<Component> components = [];
    for(var u in jsonData){
      Component component = Component(u["id"], u["name"], u["inspection_type_id"]); 
      components.add(component);
    }
    print(components.length);
    return components;

 }
  @override
  Widget build(BuildContext context){
    
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
   
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Road Inspection Datasheet"),
        backgroundColor: Colors.greenAccent[700],
      ),
      // sexyCard("theoderic", "is the don in the Hood"),
      
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(padding:EdgeInsets.only(top:20, bottom:20), child:  Text("List of Completed Datasheet Components", style:TextStyle(fontSize:15))),
          Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "RAMs Structure Key",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.email),
          
        ),
     
      ),
    ),
          Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Structure Name",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.vpn_key),
          
        ),
     
      ),
    ),
    
     Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Zone",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.zoom_in),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "State",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.ev_station),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Road Number",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.streetview),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Road Name",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.streetview),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "GPS Latitude",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.gps_fixed),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "GPS Longitude",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.gps_fixed),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Recorded By",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.record_voice_over),
          
        ),
     
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Checked By",
          isDense: true, 
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'Montserrat'
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          prefixIcon: Icon(Icons.visibility)
          
        ),
     
      ),
    ),
    /*
      rams_structure_key: String,
    structure_name: String,
    zone: String,
    state: String,
    road_number: String,
    road_name: String,
    gps_latitude: String,
    gps_longitude: String,
    recorded_by: String,
    checked_by: String,
      */ 
          Container(height:500,
            child:FutureBuilder(
          future: _getContracts(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: Text("Loading....", style:TextStyle(fontFamily: 'Candara')),)
              );
            }
            else {
             
              return ListView.builder(
               
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int Index){
                var snapshotIndexed = snapshot.data[Index];               
                print(snapshot.data[Index].name);
                return sexyCard(snapshot.data[Index].name, snapshot.data[Index].inspection_type_id, snapshot.data[Index].id);
              }
            );
            }
            
          }
        )
          ),
          
        ],) 
        )
    );
  }

Widget sexyCard(String title, String description, String id){
  return(
      new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context,'/components');
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
                          image: NetworkImage("https://png.pngtree.com/png-vector/20190511/ourmid/pngtree-vector-road-bridge-icon-png-image_1029283.jpg"))
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
    if(title!=null && description!=null){
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
            child: Center(child: Text(description, style:TextStyle(fontSize:15, fontFamily:'Candara')),)
          ),
          Padding(
            padding: EdgeInsets.only(right:10, left:60),
            child:SizedBox(
             height:100,
             width:150,
             
           child: TextFormField(
            
              onChanged: (val) {
               _saveChanges(val, title);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border: InputBorder.none,                      
              hintText: "score",
              
              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide',fontSize:14 )
            )
          )
          ),
          )
           
        ],
        )
    );
    }
    else return null;
    
  }
}

class Component {
    String id;
    String name;
    String inspection_type_id;

    Component(
        this.id,
        this.name,
        this.inspection_type_id,

    );

}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) { 
    print(oldValue);
    if(newValue.text == '')
      return TextEditingValue();
    else if(int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > int.parse(oldValue.text) ? TextEditingValue().copyWith(text: '$oldValue') : newValue;
  }
}