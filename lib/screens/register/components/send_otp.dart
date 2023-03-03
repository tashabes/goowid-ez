import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../api/api.dart';
import '../../../core/client/http_client.dart';
import '../../../core/failure/failure.dart';
import '../../../utils/app_flushbar.dart';
import '../../../utils/app_logger.dart';

void sendOtp(BuildContext context, String username) async {
  print("Calling");

  try {
    Map data = {
      'userName': username,
    };
    print(data.toString());
    HttpClient httpClient = HttpClient();
    Response? res = await httpClient.post(
      SENDPHONEOTP,
      data,
      headers: {
        "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
        "Content-Type": "application/json"
      },
    );

    AppLogger.log("This is the result: ======> ${res?.data}");

    if (res?.data == "Success") {
      GoodWidFlushBar.showSuccess(
          message: "Your 6 digit code has been sent", context: context);
    }
  } on Failure catch (e) {
    GoodWidFlushBar.showError(message: e.errorMessage, context: context);

    AppLogger.log("Error:  =====> ${e.errorMessage}");
  } catch (e) {
    AppLogger.log("Error:  =====> $e");
    AppLogger.log(e.toString());
    GoodWidFlushBar.showError(
        message: "Something went wrong, try again later", context: context);
  }
}
