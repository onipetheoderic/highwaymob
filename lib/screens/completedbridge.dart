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


class CompletedBridge extends StatefulWidget {
  static const routeName = '/datasheet_component';
 
  @override
  _DatasheetComponentState createState() => _DatasheetComponentState();
}

class _DatasheetComponentState extends State<CompletedBridge> {
  
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
    var data = await http.get("localhost:5000/create_completed_datasheet/theoderic_inspection/completed_bridge", headers: {"Accept": "application/json", "authorization":bearer});
    var jsonData = json.decode(data.body);
 
    List<Component> components = [];
    for(var u in jsonData){
      Component component = Component(u["highway_inspector_id"], u["datasheet_id"], u["component_score"], u["component_name"], u["component_id"]); 
      components.add(component);
    }
    print(components.length);
    return components;

 }
  @override
  Widget build(BuildContext context){
    
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=args.id;
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        backgroundColor: Colors.greenAccent[700],
      ),
      // sexyCard("theoderic", "is the don in the Hood"),
      body: Container(
        child: FutureBuilder(
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
                            
                return sexyCard(snapshot.data[Index].component_name, snapshot.data[Index].component_score, snapshot.data[Index].component_id);
              }
            );
            }
            
          }
        )
        )
    );
  }

Widget sexyCard(String title, int description, String id){
  return(
      new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context,'/components', arguments:id);
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


  Widget myDetailContainer(String title, int description, String id){
    if(title!=null && description!=null && id!=null){
return(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right:10, left:20),
            child: Center(child: Text(title, style:TextStyle(fontSize:20, fontFamily:'Candara')),)
          ),
           SizedBox(
             height:100,
             width:50,
             
           child: TextFormField(
             initialValue:description.toString(),
              onChanged: (val) {
               _saveChanges(val, id);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              border: InputBorder.none,                      
              hintText:description.toString(),
              
              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide',fontSize:14 )
            )
          )
          ),
        ],
        )
    );
    }
    else return null;
    
  }
}

class Component {
    String highway_inspector_id;
    String datasheet_id;
    int component_score;
    String component_name;
    String component_id;

    Component(
        this.highway_inspector_id,
        this.datasheet_id,
        this.component_score,
        this.component_name,
        this.component_id,
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