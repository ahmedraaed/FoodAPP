import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/models/sgin_up_model.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo
{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences,required this.apiClient});


  Future<Response> registeration(SignUpBody signUpBody)async
  {
    return await apiClient.postData(AppConstant.Regestration_url, signUpBody.tojson());
  }
  Future<Response> Login(String phone,String password)
  async {
    return await apiClient.postData(AppConstant.Login_url,{"phone":phone,"password":password});
  }
  Future<bool> saveToken(String token)async
  {
    apiClient.token=token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstant.Token, token);
  }

  bool checkToken()
  {
    return sharedPreferences.containsKey(AppConstant.Token);
  }
  Future<String?> getToken()async
  {
    return await sharedPreferences.getString(AppConstant.Token);
  }
  Future<void> saveEmailAndPassword(String phone,String password) async
  {
    try{
      await sharedPreferences.setString(AppConstant.phone, phone);
      await sharedPreferences.setString(AppConstant.password, password);
    }catch(e)
    {
      throw e;
    }
  }
  clear()
  {
    sharedPreferences.remove(AppConstant.Token);
    sharedPreferences.remove(AppConstant.password);
    sharedPreferences.remove(AppConstant.phone);
  }

}