import 'package:flutter/material.dart';
import 'forgotscreen.dart';
import 'dashboardscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'dart:async';


class Datasheet extends StatefulWidget {
  @override
  _DatasheetState createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {
//   void initState() {
//   super.initState();
//   _getContracts();
// }

 Future<List<Contract>> _getContracts() async{
    final storage = new FlutterSecureStorage();
    final value = await storage.read(key: 'token');
    print("XXXXXXXXXXX$value");
    final bearer = "Bearer "+value;
    var data = await http.get("http://localhost:5000/api/datasheet_select", headers: {"Accept": "application/json", "authorization":bearer});
    var jsonData = json.decode(data.body);
    List<Contract> contracts = [];
    for(var u in jsonData){
      Contract contract = Contract(u["prioritize"], u["id"], u["projectTitle"], u["state"], u["lga"], u["contractType"]); 
      contracts.add(contract);
    }
    print(contracts.length);
    return contracts;

 }
//  void initState() {
//   super.initState();
//   _initResponse();
// }


//  void _initResponse() async {
//    final storage = new FlutterSecureStorage();
//    final value = await storage.read(key: 'token');
//    print("UUUUUUUUUUUUUUUUUU$value");
//    final bearer = "Bearer "+value;
//     var response = await http.get("http://localhost:5000/api/datasheet_select", headers: {"Accept": "application/json", "authorization":bearer});
//   var list =json.decode(response.body) as List;
//   print(list);

// }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects You are Assigned To"),
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
                String state = snapshotIndexed.state;
                String lga = snapshotIndexed.lga;
                String contractType = snapshotIndexed.contractType;
                String description = "State: $state, L.G.A: $lga";                
                return sexyCard(snapshot.data[Index].projectTitle, description);
              }
            );
            }
            
          }
        )
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

class Contract {
    bool prioritize;
    String id;
    String projectTitle;
    String state;
    String lga;
    String contractType;

    Contract(
        this.prioritize,
        this.id,
        this.projectTitle,
        this.state,
        this.lga,
        this.contractType,
    );

}
