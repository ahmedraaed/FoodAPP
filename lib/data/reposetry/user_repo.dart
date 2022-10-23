import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class UserRepo
{
  ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getDatainfo()
  async {
    return await apiClient.getData(AppConstant.User_INF_Url);
  }
}