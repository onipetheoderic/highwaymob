import 'package:flutter/material.dart';

class GridDashboard extends StatelessWidget {
  
  Items item1 = new Items(
    
    title: "Upload Images",
    subtitle: "March, Wednesday",
    link: "/camera",
    img: "assets/images/icon1.png"
  );
  Items item2 = new Items(
    title: "View Inspections",
    subtitle: "March, Wednesday",
    link: "3 links",
    img: "assets/images/icon2.png"
  );
  Items item3 = new Items(
    title: "Messages",
    subtitle: "March, Wednesday",
    link: "3 links",
    img: "assets/images/icon3.png"
  );
  Items item4 = new Items(
    title: "My Projects",
    subtitle: "March, Wednesday",
    link: "3 links",
    img: "assets/images/icon4.png"
  );
  Items item5 = new Items(
    title: "Ongoing Inspection",
    subtitle: "March, Wednesday",
    link: "/datasheet",
    img: "assets/images/icon5.png"
  );
  Items item6 = new Items(
    title: "Completed Projects",
    subtitle: "March, Wednesday",
    link: "/completed_datasheet",
    img: "assets/images/icon6.png"
  );
  @override
  
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    var color2 = 0xfffffff;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left:16, right:16),
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        children: myList.map((data){
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
             onTap: () {
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text(data.subtitle),
        // ));
         Navigator.pushNamed(context, data.link);
      },
            child:Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 SizedBox(height: 7,),
               Image.asset(data.img, width:42),
               SizedBox(height: 7,),
               Text(data.title, style: TextStyle(
                 color: Colors.black, 
               fontFamily: 'Montserrat', 
               fontSize:10, fontWeight: FontWeight.w600),
               ),
              SizedBox(height:8),
              
              
              ],
            )
          )
          );
        }).toList()
      ),
    );
  }

}
class Items {
  String title;
  String subtitle;
  String link;
  String img;
  Items({this.title, this.subtitle, this.link, this.img});
}