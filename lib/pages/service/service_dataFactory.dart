import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import '../config/service_address.dart';


Future requestData(method,url,formData) async {
  try {
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    Response rsp;
    if (method == 'get' || method == 'GET') {
      if (formData != null) {
        rsp = await dio.get(servicePath[url],queryParameters: formData);
      }else {
        rsp = await dio.get(servicePath[url]);
      }
    }else {
      if (formData != null) {
        rsp = await dio.post(servicePath[url],data: formData);
      }else {
        rsp = await dio.post(servicePath[url]);
      }
    }
    if (rsp.statusCode == 200) {
      return rsp.data;
    }else {
      throw Exception('请求保错');
    }
  } catch(e)  {
    return print(e);
  }
}


Future getHomeData() async {
  try {
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    final formData = {'lon':'115.02932','lat':'35.76189'};
    Response rsp = await dio.post(servicePath['homeContent'],data: formData);
    if (rsp.statusCode == 200) {
      return rsp.data;
    }else {
      throw Exception('首页请求保错');
    }
  } catch(e)  {
    return print(e);
  }
}