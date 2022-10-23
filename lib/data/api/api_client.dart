import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
//https://mvs.bslmeiyu.com/api/v1/products/popular

class ApiClient extends GetConnect implements GetxService
{
  late SharedPreferences sharedPreferences;
  late String token;
  final String appBasseutl;
  late Map<String,String>? _mainHeaders;


  ApiClient({required this.appBasseutl,required this.sharedPreferences}){

    token=sharedPreferences.getString(AppConstant.Token)??"";
    baseUrl=appBasseutl;
    timeout=Duration(seconds: 30);
    _mainHeaders={
      'Content-type':'application/json ; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }
  void updateHeaders(String token)
  {
    _mainHeaders={
      'Content-type':'application/json ; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<Response> getData(String url, {Map<String, String>? header})async
  {
    try{
      Response response=await get(url,headers:header??_mainHeaders );
      return response;
    }catch(e)
    {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }


  Future<Response> postData(String uri,dynamic body)async
  {
    try{
      Response response = await post(uri, body,headers: _mainHeaders);
      return response;
    }catch(e)
    {
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}