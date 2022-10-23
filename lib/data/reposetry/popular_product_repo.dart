import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';

class PopularProductRpo extends GetxService
{
  final ApiClient apiClient;

  PopularProductRpo({required this.apiClient});

  Future<Response> getPopularProductListRepo()async
  {
    return await apiClient.getData(AppConstant.Popular_Endpoint_url);
  }

}