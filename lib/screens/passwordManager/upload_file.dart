import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../core/client/http_client.dart';
import '../../utils/app_flushbar.dart';
import '../../utils/app_logger.dart';
import '../../core/failure/failure.dart';
import 'dart:io';

class UploadFile extends StatefulWidget {
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final _formKey = GlobalKey<FormState>();
  late String file, fileName, id, email;
  late String? title;
  bool isLoading = false;
  TextEditingController _fileNameController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _obscureText = true;
  FilePickerResult? result;
  FormData? formData;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 180,
                        child: const Text(
                          "Goowid Authenticator",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: 0.6,
                              fontFamily: 'Poppins',
                              fontSize: 11),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Upload a file",
                        //textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Selected file",
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: result?.files.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      result?.files[index].name ?? '',
                                    );
                                  }),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        width: 5.0,
                                        color: Color(0xFFF77D8E),
                                      )),
                                  onPressed: () async {
                                    result =
                                        await FilePicker.platform.pickFiles();
                                    if (result == null) {
                                      print('No file selected');
                                    } else {
                                      File imageFile =
                                          File(result?.files.single.path ?? '');
                                      formData = FormData.fromMap({
                                        'file': await MultipartFile.fromFile(
                                            imageFile.path,
                                            filename:
                                                imageFile.path.split('/').last),
                                        'id': id,
                                      });

                                      setState(() {});
                                      result?.files.forEach((element) {
                                        print(element.name);
                                        file = element.name;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Choose your file",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';

// void uploadImage() async {
//   // Create a Dio instance
//   Dio dio = new Dio();

//   // Define the API endpoint for the upload request
//   String apiUrl = 'https://example.com/api/upload';

//   // Allow the user to select an image file
//   FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

//   if (result != null) {
//     // Create a FormData object to hold the image data
//     File imageFile = File(result.files.single.path);
//     FormData formData = new FormData.fromMap({
//       "image": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
//     });

//     // Send the request to the server
//     try {
//       Response response = await dio.post(apiUrl, data: formData);
//       print(response.data);
//     } catch (e) {
//       print(e);
//     }
//   } else {
//     // User canceled the file picker
//     return;
//   }
// }

                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                controller: _fileNameController,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  hintText: "File Name",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  fileName = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // TextFormField(
                              //   style: const TextStyle(
                              //     color: Colors.black54,
                              //   ),
                              //   controller: _categoryController,
                              //   enableSuggestions: false,
                              //   autocorrect: false,
                              //   decoration: const InputDecoration(
                              //     enabledBorder: UnderlineInputBorder(
                              //         borderSide:
                              //             BorderSide(color: Colors.black12)),
                              //     hintText: "Category (optional)",
                              //     hintStyle: TextStyle(
                              //         color: Colors.black54, fontSize: 15),
                              //   ),
                              //   onSaved: (val) {
                              //     category = val!;
                              //   },
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (isLoading) {
                                        return;
                                      }
                                      if (_fileNameController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please enter your file name")));
                                        return;
                                      }

                                      UploadDocument(formData!, _id);
                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                      //Navigator.pushReplacementNamed(
                                      //context, "/entrypoint");
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF77D8E),
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Text(
                                        "Upload",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: (isLoading)
                                        ? Center(
                                            child: Container(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    const CircularProgressIndicator(
                                                  backgroundColor: Colors.green,
                                                )))
                                        : Container(),
                                    right: 30,
                                    bottom: 0,
                                    top: 0,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, docMgmt);
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  UploadDocument(FormData formData, id) async {
    print("Calling");

    try {
      Map<String, dynamic> newData = {'file': '', 'fileName': '', 'id': "$id"};
      FormData data = formData;

      print(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        UPLOADFILE,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          'Content-Type': 'multipart/form-data',
        },
      );
      setState(() {
        isLoading = false;
      });

      AppLogger.log("This is the result: ======> ${res!.statusCode}");

      if (res.statusCode == 200) {
        GoodWidFlushBar.showSuccess(
            message: "Your document has been successfully uploaded",
            context: context);
        _fileNameController.clear;
        setState(() {
          isLoading = false;
        });
      }
    } on Failure catch (e) {
      //scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.errorMessage)));
      GoodWidFlushBar.showError(message: e.errorMessage, context: context);
      setState(() {
        isLoading = false;
      });
      AppLogger.log("Error:  =====> ${e.errorMessage}");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      AppLogger.log("Error:  =====> $e");
      AppLogger.log(e.toString());
      GoodWidFlushBar.showError(
          message: "Something went wrong, try again later", context: context);
    }
  }

  String? _id;

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _id = preferences.getString('id')!;
    });
  }

  // void getUserId(userName) async {
  //   print("Calling");

  //   try {
  //     Map data = {
  //       'email': userName,
  //     };
  //     print(data.toString());
  //     HttpClient httpClient = HttpClient();
  //     Response? res = await httpClient.get(
  //       GETUSER,
  //       headers: {
  //         "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
  //         "Content-Type": "application/json"
  //       },
  //     );
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Map<String, dynamic> resposne = res?.data;

  //     AppLogger.log("This is the result: ======> ${res?.data}");

  //     if (res!.statusCode == 200) {
  //       Navigator.pushReplacementNamed(context, otpVerifyMobile);
  //       GoodWidFlushBar.showSuccess(
  //           message: "Your document has been successfully uploaded",
  //           context: context);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } on Failure catch (e) {
  //     //scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.errorMessage)));
  //     GoodWidFlushBar.showError(message: e.errorMessage, context: context);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     AppLogger.log("Error:  =====> ${e.errorMessage}");
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     AppLogger.log("Error:  =====> $e");
  //     AppLogger.log(e.toString());
  //     GoodWidFlushBar.showError(
  //         message: "Something went wrong, try again later", context: context);
  //   }
  // }

  // getUserId(email) async {
  //   print("Calling");

  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     Map data = {
  //       'userName': email,
  //     };
  //     print(data.toString());
  //     HttpClient httpClient = HttpClient();
  //     Response? res = await httpClient.get(
  //       "$GETUSER/$email",
  //       headers: {
  //         "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
  //         "Content-Type": "application/json"
  //       },
  //     );
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Map<String, dynamic> resposne = res?.data;

  //     AppLogger.log("This is the result: ======> ${res?.data}");

  //     if (resposne['displayName'] != null) {
  //       //return user;
  //       // User user = resposne['user'];
  //       //Provider.of<UserProvider>(context, listen: false).setUser(user);
  //       savePref(
  //         resposne['id'],
  //       );

  //       GoodWidFlushBar.showSuccess(message: "Success", context: context);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } on Failure catch (e) {
  //     //scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.errorMessage)));
  //     GoodWidFlushBar.showError(message: e.errorMessage, context: context);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     AppLogger.log("Error:  =====> ${e.errorMessage}");
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     AppLogger.log("Error:  =====> $e");
  //     AppLogger.log(e.toString());
  //     GoodWidFlushBar.showError(
  //         message: "Something went wrong, try again later", context: context);
  //   }
  // }

  // savePref(
  //   String id,
  // ) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   preferences.setString("id", id);
  // }

  // Future<String> getUser() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();

  //   String? _id = preferences.getString("id");
  //   return user;
  // }
}
