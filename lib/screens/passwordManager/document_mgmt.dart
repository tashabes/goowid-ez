import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/entryPoint/entry_point.dart';
import 'package:goowid_auth/screens/passwordManager/upload.dart';
import 'package:goowid_auth/screens/passwordManager/upload_file.dart';
import 'package:goowid_auth/widgets/app_bar.dart';

class DocumentMgmt extends StatefulWidget {
  const DocumentMgmt({super.key});

  @override
  State<DocumentMgmt> createState() => _DocumentMgmtState();
}

class _DocumentMgmtState extends State<DocumentMgmt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResusableBar(),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadFile(),
              ),
            );
          },
          backgroundColor: Color(0xFFF77D8E),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          getStorageBox(),
          const SizedBox(
            height: 30,
          ),
          getRecentFiles(),
          const SizedBox(
            height: 30,
          ),
          getCategoryFiles(),
        ]),
      ),
    ));
  }

  Widget getCategoryFiles() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 150,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Color(0xFF7553F6).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset(categoryJson[index]['img'],width: 40,),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(categoryJson[index]['text'],style: TextStyle(
                        //   fontSize:15,
                        //   fontWeight: FontWeight.w500
                        // ),),
                        // SizedBox(height: 10,),
                        //  Text(categoryJson[index]['file_count'],style: TextStyle(
                        //   fontSize:14,
                        //   fontWeight: FontWeight.w500,
                        //   color: Color(0xFF7553F6).withOpacity(0.5)
                        // ),),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget getRecentFiles() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      width: size.width * 0.6,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Color(0xFF80A4FF),
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                            image: NetworkImage("url"), fit: BoxFit.cover),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlurryContainer(
                              blur: 5,
                              child: Padding(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  width: size.width * 0.6,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                  );
                }),
              ))
        ],
      ),
    );
  }

  Widget getStorageBox() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFF7553F6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(children: [
        Positioned(
          bottom: -40,
          right: -30,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -50,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          ),
        ),
        Container(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: CircleProgressBar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    value: 0.68,
                    child: const Center(
                      child: AnimatedCount(
                        style: TextStyle(color: Colors.white),
                        count: 0.68,
                        unit: "%",
                        duration: Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "10.8 GB of 15 GB used",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 10, bottom: 10),
                          child: Text(
                            'Buy Storage',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
