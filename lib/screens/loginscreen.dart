import 'package:flutter/material.dart';
import 'forgotscreen.dart';
import 'dashboardscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  String _msg = "";
  bool isLoading=false;
  
  void _showLoginMsg(String msgValue){
    setState((){
      _msg = msgValue;
    });
  }
  

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myEmailController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }
void _LoginUser(String email, String password) async{
  setState((){
      isLoading=true;
    });
  print("$email, $password");
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse("http://localhost:5000/api/login"));
  
  request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  request.write('{"email": "$email","password": "$password"}');

  final response = await request.close();

  response.transform(utf8.decoder).listen((contents) {
  print("PPcontents $contents");
  Map<String, dynamic> responseJson = json.decode(contents);  
  bool successStat = responseJson["success"];
  String responseMsg = responseJson["message"];
  String role = responseJson["role"];
  String user_token = responseJson["user_token"];
  if(successStat==false){
    setState((){
      isLoading = false;
      _msg = responseMsg;
    });
// _showLoginMsg(responseMsg);
  }
  else if(successStat==true){
    final storage = new FlutterSecureStorage();

// Write value 
storage.write(key: 'token', value: user_token);
storage.write(key: 'role', value: role);
    Navigator.pushNamed(context,"/dashboard");
  }
  });
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
     backgroundColor: Colors.white,
    //  resizeToAvoidBottomPadding: false,
     body: Center(
       child: SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
          
           Container(
             height:280,
             child: Stack(
               children: <Widget>[
                  
                  Positioned(
                               
                    child: Container(
                      
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bgdash.png'),
                          fit: BoxFit.cover
                        )
                      )
                    ),
                  ),
                  Positioned(   
                    height: 80.0,
                    width: 80.0,  
                    right:10,   
                    top:190,           
                    child: Container(                    
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/logo.png'),
                          
                        )
                      )
                    ),
                  ),
                  Positioned(   
                    top:100, 
                    left:20,                           
                    child: Container(
                     child: Center(
                     child: Text("Highway Management", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide', fontSize:25),),
                   )
                    ),
                  ),
                  
               ],
             )
           ),
           SizedBox(height:10.0),
       
           Padding(
             padding: EdgeInsets.symmetric(horizontal:20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 isLoading ? Center(child: CircularProgressIndicator(),) :
                 Text(_msg, style: TextStyle(color: Colors.red[700], fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Audiowide',),),
                 
                 SizedBox(height:10.0),
                 Container(
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.white,
                     boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(17, 171, 54,1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                     ]
                   ),
                   child: Column(children: <Widget>[
                     Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: Colors.grey[200]
                        ))
                       ),
                    child: TextField(
                       controller: myEmailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                       
                        hintText:"Username",
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide')
                      )
                    )
                     ),    Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: Colors.grey[200]
                        ))
                       ),
                    child: TextField(
                       controller: myPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                        border: InputBorder.none,                      
                        hintText:"Password",
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide')
                      )
                    )
                     )
                   ],)
                 ),
                 SizedBox(height:30.0),
                  new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,'/forgot_your_password');
                  },
                  child: new Text("Forgot your Password?", style:TextStyle(color:Color.fromRGBO(17, 171, 54,1))),
                  ),
                 //Text("Forgot your Password?", style:TextStyle(color:Color.fromRGBO(17, 171, 54,1))),
                 SizedBox(height:30.0),
                  GestureDetector(
                  onTap: () =>_LoginUser(myEmailController.text, myPasswordController.text),
                  
                  child: new Container(                 
                    height:50,
                    margin: EdgeInsets.symmetric(horizontal:30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(5, 77, 22, 1),
                    ),
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide'),),
                    )
                  ),          
              ),
                 
               ]
             ),
           )
           
         ],
    ),
     ),
    
    )
    );
  }
}