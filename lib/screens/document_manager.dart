import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/passwordManager/upload.dart';
import 'package:goowid_auth/utils/routes.dart';

class DocumentManager extends StatefulWidget {
  const DocumentManager({super.key});

  @override
  State<DocumentManager> createState() => _DocumentManagerState();
}

class _DocumentManagerState extends State<DocumentManager> {
  List<String> labels = ['Documents', 'Pictures', 'Passwords', 'Other'];
  int currentIndex = 0;
  String ti = 'Upload file';
  String sub = 'Browse and chose the files you want to upload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF77D8E),
        // Add new document button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadScreen(1, '1', ti, sub),
              ),
            );
          },
          backgroundColor: Color(0xFFF77D8E),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
// Appbar

        // Back floating button
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, homePage);
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                //Flexible(child: ,fit: FlexFit.tight,),
                SizedBox(width: 10.0),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75.0),
                    topRight: Radius.circular(75.0)),
              ),
              child: ListView(
                  primary: false,
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height - 300.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ToggleBar(
                                  //   labels: labels,
                                  //   textColor: Colors.black,
                                  //   backgroundColor: Colors.transparent,
                                  //   labelTextStyle:
                                  //       TextStyle(fontWeight: FontWeight.w500),
                                  //   selectedTextColor: Colors.black,
                                  //   selectedTabColor: Colors.amber,
                                  //   onSelectionUpdated: (index) =>
                                  //       setState(() => currentIndex = index),
                                  // ),
                                  Expanded(
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(25),
                                      children: <Widget>[
                                        // const MyCard(
                                        //     Colors.amber, 'Voice recording'),
                                        // const MyCard(
                                        //     Colors.amberAccent, 'Rehersals'),
                                        // const MyCard(Colors.grey, 'Audio'),
                                      ],
                                    ),
                                  )
                                ]))),
                  ])),
        ]));
  }
}
