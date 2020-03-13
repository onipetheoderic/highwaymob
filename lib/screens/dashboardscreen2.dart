import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dashboardscreen.dart';
import 'forgotscreen.dart';
class DashboardScreen2 extends StatefulWidget {
  @override
  _DashboardScreen2State createState() => _DashboardScreen2State();
}

class _DashboardScreen2State extends State<DashboardScreen2> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

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
                   child: Text("Highway Management 2", style: TextStyle(color: Colors.white, fontFamily: 'Audiowide', fontSize:25),),
                 )
                  ),
                ),
             ],
           )
         ),
         SizedBox(height:10.0),

       ],
    ),
    bottomNavigationBar: CurvedNavigationBar(
     
      items: <Widget>[
        Icon(Icons.home, size:20.0, color:Colors.black),
        Icon(Icons.add, size:20.0, color:Colors.black),
        Icon(Icons.list, size:20.0, color:Colors.black),
        Icon(Icons.cloud_upload, size:20.0, color:Colors.black),
        Icon(Icons.message, size:20.0, color:Colors.black),
       
      ],
      backgroundColor: Colors.white,
      height: 50,
      index:1,
      buttonBackgroundColor: Colors.greenAccent[700],
      animationDuration: Duration(milliseconds: 400),
      color: Colors.greenAccent[700],
      onTap: (index){
        if(index==0){
           Navigator.push(context,  MaterialPageRoute(
           builder: (context) =>DashboardScreen(),
         ),);
        }
      }
      )
    );
  }
}