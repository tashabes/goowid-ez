import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../utils/app_flushbar.dart';
import '../../utils/app_logger.dart';
import '../../widgets/app_bar.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  late String? title;
  bool isLoading = false;
  TextEditingController _fileNameController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _obscureText = true;
  FilePickerResult? result;
  PlatformFile? file;

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
        extendBodyBehindAppBar: true,
        appBar: const ResusableBar(),
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
                                        width: 4.0,
                                        color: Color(0xFFF77D8E),
                                      )),
                                  onPressed: () async {
                                    result =
                                        await FilePicker.platform.pickFiles();
                                    if (result == null) {
                                      AppLogger.log('No file selected');
                                    } else {
                                      file = result?.files.first;
                                      setState(() {});
                                      result?.files.forEach((element) {
                                        AppLogger.log(element.name);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Choose your file",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
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
                                  password = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
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
                                                    "Please enter a file name")));
                                        return;
                                      }

                                      uploadFile(
                                          file, _fileNameController.text, _id);
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
                          Navigator.pop(context, docMgmt);
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

  Future uploadFile(file, fileName, id) async {
    AppLogger.log('Calling');
    var dio = Dio();

    setState(() {
      isLoading = true;
    });

    //FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (file != null) {
      PlatformFile file = result!.files.first;
      AppLogger.log(file.name);
      //AppLogger.log(file.bytes);
      //AppLogger.log(file.size);
      AppLogger.log(file.extension);
      AppLogger.log(file.path);

      String? filename = file.path?.split('/').last;

      String? filepath = file.path;

      FormData data = FormData.fromMap({
        //'key': '5d94951785ea4e3d9f414c5b2d3d6f80',
        'file': await MultipartFile.fromFile(filepath!, filename: filename),
        'fileName': fileName,
        'id': id
      });
      AppLogger.log(data.toString());

      var response = await dio.post(UPLOADFILE,
          data: data,
          options: Options(headers: {
            "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
            "Content-Type": "application/json"
          }), onSendProgress: (int sent, int total) {
        AppLogger.log('This is the response $sent, $total');
      });
      setState(() {
        isLoading = false;
      });
      if (response.data == 'Saved!') {
        GoodWidFlushBar.showSuccess(
            message: "File successfully uploaded", context: context);
        AppLogger.log('Success');
        setState(() {
          isLoading = false;
        });
      }
      AppLogger.log(response.data);
    } else {
      AppLogger.log("Result is null");
      GoodWidFlushBar.showError(message: "File not uploaded", context: context);
      setState(() {
        isLoading = false;
      });
    }
  }

  String? _id;

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _id = preferences.getString('id') ?? '';
    });
  }
}
