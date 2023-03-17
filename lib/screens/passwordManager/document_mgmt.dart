import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/passwordManager/upload_file.dart';
import 'package:goowid_auth/widgets/app_bar.dart';

class DocumentMgmt extends StatefulWidget {
  const DocumentMgmt({super.key});

  @override
  State<DocumentMgmt> createState() => _DocumentMgmtState();
}

class _DocumentMgmtState extends State<DocumentMgmt> {
  List<Map<String, String>> category = [
    {
      "assets": "assets/icons/passport.png",
      "name": "ID",
    },
    {
      "assets": "assets/icons/budget.png",
      "name": "Finances",
    },
    {
      "assets": "assets/icons/patient.png",
      "name": "Medical",
    },
    {
      "assets": "assets/icons/insurance.png",
      "name": "Insurance",
    },
    {
      "assets": "assets/icons/image-gallery.png",
      "name": "Photos",
    },
    {
      "assets": "assets/icons/employed.png",
      "name": "Employment",
    },
    {
      "assets": "assets/icons/car-insurance.png",
      "name": "Vehicle",
    },
  ];

  List<Map<String, String>> recentFiles = [
    {
      "assets": "assets/images/holiday.jpeg",
      "name": "Holiday 2022",
    },
    {
      "assets": "assets/images/passport.png",
      "name": "Passport",
    },
    {
      "assets": "assets/images/1140-vaccination-card.jpg",
      "name": "Vaccination card",
    },
    {
      "assets": "assets/images/car_insurance.jpg",
      "name": "Car Insurance",
    },
    {
      "assets": "assets/images/christmas.jpg",
      "name": "Christmas 2022",
    },
    {
      "assets": "assets/images/employment.png",
      "name": "Employment contract",
    },
    {
      "assets": "assets/images/car_insurance.jpg",
      "name": "Holiday Insurance",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ResusableBar(
        title: 'My Documents',
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadFile(),
              ),
            );
          },
          backgroundColor: const Color(0xFFF77D8E),
          child: const Icon(
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
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(7, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 150,
                    width: 140,
                    decoration: BoxDecoration(
                        color: const Color(0xFF7553F6).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // Image.asset(
                        //   'assets/icons/passport.png',
                        //   width: 60,
                        // ),
                        // Icon(
                        //   _iconTypes[index],
                        // ),
                        Image.asset(
                          category[index]['assets']!,
                          width: 40,
                        ),

                        //Image.asset(categoryJson[index]['img'],width: 40,),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          category[index]['name']!,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
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
                children: List.generate(7, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      width: size.width * 0.6,
                      height: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFF80A4FF),
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                            image: AssetImage(recentFiles[index]['assets']!),
                            fit: BoxFit.cover),
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
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  child: Text(recentFiles[index]['name']!,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 18,
                                      )),
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
        color: const Color(0xFF7553F6),
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
                        child: const Padding(
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
