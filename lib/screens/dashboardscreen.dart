import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'forgotscreen.dart';
import 'components/griddashboard.dart';

class DashboardScreen extends StatelessWidget {
 Container MyArticles(String imageVal, String heading, String subHeading){
   return Container(
     width:140.0,
     child: Card(
       child: Wrap(
         children: <Widget>[
           Image.network(imageVal, height:100),
           ListTile(
             title: Text(heading),
             subtitle:Text(subHeading)
           )
         ]
       )
     )

   );
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
     backgroundColor: Colors.greenAccent[700],
     body: Column(children:<Widget>[
       SizedBox(height: 110,),
       Padding(padding: EdgeInsets.only(left:16, right:16),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children:<Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text("Theoderic Onipe", 
               style: TextStyle(
                 color: Colors.black, 
               fontFamily: 'Audiowide', 
               fontSize:18)),
               SizedBox(height:4),
                Text("Home", 
               style: TextStyle(
                 color: Colors.black, 
               fontFamily: 'Audiowide', 
               fontSize:14)),
             ],
            ),
            IconButton(
              alignment: Alignment.topCenter,
              onPressed: (){},
              icon:Icon(Icons.notifications, size:20),
            )
         ]
       ),
       ),
       SizedBox(height: 20,),
       GridDashboard(),
      
       Container(
         margin: EdgeInsets.symmetric(vertical:10.0),
         height:170,
         child: ListView(
           scrollDirection: Axis.horizontal,
           children:<Widget>[
             MyArticles("https://cdn.shortpixel.ai/client/to_webp,q_lossless,ret_img,w_1024/https://www.beltandroad.news/wp-content/uploads/2019/07/Nigeria-Road-Construction.jpg","heading 1","subtitle1"),
             MyArticles("https://www.graphic.com.gh/images/stories/construction.jpg","heading 2","subtitle2"),
             MyArticles("http://news.statetimes.in/wp-content/uploads/2014/11/rail-ingra.jpg?x39047","heading 3","subtitle3"),
             MyArticles("https://www.nation.co.ke/image/view/-/4953272/medRes/1613017/-/maxw/600/-/fjuq2sz/-/road.jpg","heading 2","subtitle2"),
             MyArticles("http://www.mpiafrica.com/wp-content/uploads/2019/03/Sagez-Nigeria-Road-Construction-Image-4-300x185.jpg","heading 1","subtitle1"),
           ]
         )
       ),
     SizedBox(height: 20,),
     ]
     )
    );
  }
}