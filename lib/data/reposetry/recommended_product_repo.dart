import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';

class RecommendedProductRpo extends GetxService
{
  final ApiClient apiClient;

  RecommendedProductRpo({required this.apiClient});

  Future<Response> getRecommendedProductListRepo()async
  {
    return await apiClient.getData(AppConstant.Recommended_Endpoint_url);
  }

}