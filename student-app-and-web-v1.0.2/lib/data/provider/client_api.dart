import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_lms_flutter/core/common_models/errrors_model.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:http/http.dart' as Http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    printLog('Token: $token');


    ///pick zone id to update header
    updateHeader(
      token, sharedPreferences.getString(AppConstants.languageCode),
    );
  }
  void updateHeader(String? token, String? languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.localizationKey: languageCode ?? AppConstants.languages[0].languageCode!,
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    printLog("appBaseUrl:${appBaseUrl!+uri}");
    try {
      Http.Response response = await Http.get(
        Uri.parse(appBaseUrl!+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    Http.Response response = await Http.post(
      Uri.parse(appBaseUrl!+uri!),
      body: jsonEncode(body),
      headers: headers ?? _mainHeaders,
    ).timeout(Duration(seconds: timeoutInSeconds));
    try {
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartDataConversation(
      String? uri, Map<String, String> body,
      List<MultipartBody>? multipartBody,
      MultipartBody? logo,
      {Map<String, String>? headers,File? otherFile}) async {

    debugPrint('====> API Body: $body');
    Http.MultipartRequest request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
    request.headers.addAll(headers ?? _mainHeaders);


    if(logo != null){
      ///logo added here
      File file = File(logo.file.path);
      request.files.add(Http.MultipartFile(
        logo.key!, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last,
      ));
    }

    if(otherFile != null) {
      Uint8List list = await otherFile.readAsBytes();
      var part = Http.MultipartFile('files[]', otherFile.readAsBytes().asStream(), list.length, filename: basename(otherFile.path));
      request.files.add(part);
    }


    ///identity images added here
    if(multipartBody!=null){
      for(MultipartBody multipart in multipartBody) {
        File file = File(multipart.file.path);
        request.files.add(Http.MultipartFile(
          multipart.key!, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last,
        ));
      }
    }

    request.fields.addAll(body);

    Http.Response response = await Http.Response.fromStream(await request.send());
    printLog("check_reg._postMultipartData_response_");
    printLog(response.body.toString());
    printLog(response);
    return handleResponse(response, uri);
  }

  Future<Response> postMultipartData(String? uri, Map<String, String> body, List<MultipartBody>? multipartBody, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.MultipartRequest request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
      request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody!) {
        if(kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          Http.MultipartFile part = Http.MultipartFile(
            multipart.key!, multipart.file.readAsBytes().asStream(), list.length,
            filename: basename(multipart.file.path), /*contentType: MediaType('images', 'jpg'),*/
          );
          request.files.add(part);
        }else {
          File file = File(multipart.file.path);
          request.files.add(Http.MultipartFile(
            multipart.key!, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      Http.Response response = await Http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      Http.Response response = await Http.put(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String? uri, {Map<String, String>? headers}) async {
    try {
      Http.Response response = await Http.delete(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String? uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(e) {}
    Response response0 = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(response0.statusCode != 200 && response0.body != null && response0.body is !String) {
      if(response0.body.toString().startsWith('{response_code:')) {
        ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.responseCode);
      }else if(response0.body.toString().startsWith('{message')) {
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
      }
    }else if(response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    printLog('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}

class MultipartBody {
  String? key;
  XFile file;

  MultipartBody(this.key, this.file);
}