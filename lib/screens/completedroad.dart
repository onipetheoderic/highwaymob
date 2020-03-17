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
  final checkedByController = TextEditingController();
   bool data_sent=false;
   bool show_second=false;
   String datasheet_id="";
  final gpsLatitudeController = TextEditingController();  
  final gpsLongitudeController = TextEditingController();
  var id;
  final ramsStructureController = TextEditingController();
  final recordedByController = TextEditingController();  
  final roadNameController = TextEditingController();
  final roadNumberController = TextEditingController();
  final stateController = TextEditingController();
  final structureNameController = TextEditingController();
  final zoneController = TextEditingController();

  @override
  void dispose() {
  ramsStructureController.dispose();
  structureNameController.dispose();
  zoneController.dispose();
  stateController.dispose();
  roadNumberController.dispose();
  roadNameController.dispose();
  gpsLatitudeController.dispose();  
  gpsLongitudeController.dispose();
  recordedByController.dispose();  
  checkedByController.dispose();
    super.dispose();
  }

  _saveChanges(String valz, String field_name, String id, String problem_name) async{
    print("from the function, $valz, $field_name, $id $problem_name");
    
    print(valz.length);  
      if(valz.length>=2){
          final storage = new FlutterSecureStorage();
          final value = await storage.read(key: 'token');
          print("DDDDDDDDDD$value");
          final bearer = "Bearer "+value;
          var data = await http.post("http://localhost:5000/api/create_completed_component", 
          body: {"problem_id":id, 
          "problem_name":field_name, 
          "completedDatasheet_id": datasheet_id,
          "value":valz, 
          "field_type":problem_name}, 
          headers: {"Accept": "application/json", "authorization":bearer});
          var jsonData = json.decode(data.body);
          print("YYYYYYYYYYYY $jsonData");      
      }
      
  }


void _SubmitRecord(String ramsStructureController, String structureNameController,
                  String zoneController, String stateController, String roadNumberController,
                  String roadNameController, String gpsLatitudeController,
                  String gpsLongitudeController, String recordedByController, 
                  String checkedByController) async{

final storage = new FlutterSecureStorage();
      final value = await storage.read(key: 'token');
      print("DDDDDDDDDD$value");
      final bearer = "Bearer "+value;
      var data = await http.post(
        
        "http://localhost:5000/api/create_completed_inspection_datasheet_post", 
      body: {'rams_structure_key': ramsStructureController, 
            'structure_name': structureNameController,
            'zone': zoneController,
            'state': stateController, 
            'road_number': roadNumberController,
            'road_name': roadNameController,
             'gps_latitude': gpsLatitudeController, 
            'gps_longitude': gpsLongitudeController,
            'recorded_by': recordedByController,
            'checked_by': checkedByController           
            },
            headers: {"Accept": "application/json", "authorization":bearer});
            var jsonData = json.decode(data.body);
            CompleteDatasheet completed = CompleteDatasheet(jsonData);
            print("YYYYYYYYYYYY $jsonData");
            print(completed.id);
      
      setState(() {
        datasheet_id = completed.id;
        data_sent=true;
        show_second=true;
      });

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
      Component component = Component(u["_id"], u["name"], u["inspection_type_id"]); 
      components.add(component);
    }
    print(components.length);
    return components;

 }

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
          (() {
                  // your code here
                  if(data_sent==false){
                           return Container(
            child: Column(
              children: <Widget>[
              

 Padding(
        padding: EdgeInsets.only(right:30, left:30, top:20),
     
      child: TextField(
        controller: ramsStructureController,
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
        controller: structureNameController,
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
        controller: zoneController,
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
        controller: stateController,
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
         controller: roadNumberController,
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
        controller: roadNameController,
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
        controller: gpsLatitudeController,
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
        controller: gpsLongitudeController,
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
        controller: recordedByController,
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
        controller: checkedByController,
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
    
             SizedBox(height:20.0),
                 GestureDetector(
            
                  onTap: () =>_SubmitRecord(
                  ramsStructureController.text, 
                  structureNameController.text,
                  zoneController.text,
                  stateController.text,
                  roadNumberController.text,
                  roadNameController.text,
                  gpsLatitudeController.text,
                  gpsLongitudeController.text,
                  recordedByController.text,
                  checkedByController.text),

                  child: new Container(                 
                  height:50,
                  margin: EdgeInsets.symmetric(horizontal:30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(5, 77, 22, 1),
                  ),
                  child: Center(
                    child: Text("Send Data", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide'),),
                  )
                ),
            ),
              SizedBox(height:30.0),
            //    GestureDetector(
            //     onTap: (){
            //       print("Container clicked");
            //     },
            //     child: new Container(                 
            //       height:50,
            //       margin: EdgeInsets.symmetric(horizontal:30),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(50),
            //         color: Color.fromRGBO(5, 77, 22, 1),
            //       ),
            //       child: Center(
            //         child: Text("Save Data", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide'),),
            //       )
            //     ),
            // ),
              ],),
          
          );
                  }
                  else{

                     return Container();

                  };
                }()),
  
         
          
   SizedBox(height:50.0),
   
  
  //  Padding(padding: EdgeInsets.only(top:10, left:10, right:10, bottom:20),
  //  child:Text("Fill In Component Information")),
  
  Container(height:500,
            child:FutureBuilder(
          future: _getContracts(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
              if(data_sent==true){
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
                    return sexyCard(snapshot.data[Index].name, snapshot.data[Index].inspection_type_id, snapshot.data[Index]._id);
                  }
                );
                }
            }
            else {
              return Container();
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
          Container(child: Row(
            children:<Widget>[
Padding(
            padding: EdgeInsets.only(right:10, left:60),
            child:SizedBox(
             height:100,
             width:80,
             
           child: TextFormField(
            
              onChanged: (val) {
               _saveChanges(val, title, id, "severity");
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border: InputBorder.none,                      
              hintText: "Severity",
              
              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide',fontSize:14 )
            )
          )
          ),
          ),
          Padding(
            padding: EdgeInsets.only(right:10, left:60),
            child:SizedBox(
             height:100,
             width:80,
             
           child: TextFormField(
            
              onChanged: (val) {
               _saveChanges(val, title, id, "extent");
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border: InputBorder.none,                      
              hintText: "Extent",
              
              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide',fontSize:14 )
            )
          )
          ),
          ),
            Padding(
            padding: EdgeInsets.only(right:10, left:60),
            child:SizedBox(
             height:100,
             width:80,
             
           child: TextFormField(
            
              onChanged: (val) {
               _saveChanges(val, title, id, "urgent");
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border: InputBorder.none,                      
              hintText: "Urgent",
              
              hintStyle: TextStyle(color: Colors.redAccent[600], fontFamily: 'AudioWide',fontSize:14 )
            )
          )
          ),
          )
            ]

          ),),
          
           
        ],
        )
    );
    }
    else return null;
    
  }
}

class Component {
    Component(
        this._id,
        this.name,
        this.inspection_type_id,

    );

    String _id;
    String inspection_type_id;
    String name;
}

class CompleteDatasheet {
    CompleteDatasheet(
        this.id,
        

    );

    String id;
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