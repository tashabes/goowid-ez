import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/api/api.dart';
import 'package:goowid_auth/screens/passwordManager/upload_file.dart';
import 'package:path_provider/path_provider.dart';

class UpTest extends StatelessWidget {
  const UpTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    uploadFile();
                  },
                  child: const Text("Upload File")),
            ],
          ),
        ),
      ),
    );
  }
// uploadFile() async{
// FilePickerResult? result = await FilePicker.platform.pickFiles(
//                       type: FileType.custom,
//                       allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4', 'mkv'],
//                     );
//                     if (result != null) {
//                       PlatformFile file = result.files.first;

//                       print(file.name);
//                       print(file.bytes);
//                       print(file.size);
//                       print(file.extension);
//                       print(file.path);
//                  var multipartFile = await MultipartFile.fromFile(file.path,
//                        );
//                     FormData formData = FormData.fromMap({

//                       "MediaFile": multipartFile,  //define your json data here
//                     });

//              functionToUploadToServer(formData); //call upload function passing multiform data
//                 }
//     }
//                 functionToUploadToServer(multiformData) async{

//                       Dio dio = Dio();

//                       final response = await dio.post(
//                         UPLOADFILE,
//                         data: multiformData,
//                         options: Options(
//                             contentType: 'multipart/form-data',
//                             headers: {},
//                             followRedirects: false,
//                             validateStatus: (status) {
//                               return status! <= 500;
//                             }),
//                       );
//                       print(response.statusCode);
//                 }
//                 }

  Future uploadFile() async {
    print('Calling');
    var dio = Dio();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      String? filename = file.path?.split('/').last;

      String? filepath = file.path;

      FormData data = FormData.fromMap({
        //'key': '5d94951785ea4e3d9f414c5b2d3d6f80',
        'file': await MultipartFile.fromFile(filepath!, filename: filename),
        'fileName': 'test',
        'id': '32c2ae32-e986-41fc-a761-4b1a3e92142b'
      });
      print(data.toString());
      HttpClient httpClient = HttpClient();
      var response = await dio.post(UPLOADFILE,
          data: data,
          options: Options(headers: {
            "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
            "Content-Type": "application/json"
          }), onSendProgress: (int sent, int total) {
        print('This is the response $sent, $total');
      });
      if (response == 'Saved!') {
        print('Success');
      }
      print(response.data);
    } else {
      print("Result is null");
    }
  }
}
