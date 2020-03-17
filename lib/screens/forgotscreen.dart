import 'package:flutter/material.dart';
import 'loginscreen.dart';
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
     backgroundColor: Colors.white,
     body: Column(
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
                        image: AssetImage('assets/images/bg.png'),
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
              //  Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Audiowide',),),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:"Enter Your Email",
                      hintStyle: TextStyle(color: Colors.grey, fontFamily: 'AudioWide')
                    )
                  )
                   )
                 ],)
               ),
               SizedBox(height:30.0),
               new GestureDetector(
                onTap: () {
                  Navigator.push(context,  MaterialPageRoute(
                  builder: (context) =>LoginScreen(),
                ),);
                },
                child: new Text("Back To Login", style:TextStyle(color:Color.fromRGBO(17, 171, 54,1))),
                ),
              
               SizedBox(height:30.0),
               GestureDetector(
                onTap: (){
                  print("Container clicked");
                },
                child: new Container(                 
                  height:50,
                  margin: EdgeInsets.symmetric(horizontal:30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(5, 77, 22, 1),
                  ),
                  child: Center(
                    child: Text("Submit", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide'),),
                  )
                ),
            ),
               


               SizedBox(height:20.0),
             
             ]
           ),
         )
         
       ],
    )
    );
  }
}