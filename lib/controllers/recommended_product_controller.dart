import 'package:foodapp/data/reposetry/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/reposetry/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController
{
  final RecommendedProductRpo recommendedProductRpo;

  RecommendedProductController({required this.recommendedProductRpo});

  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;

  bool _loading=false;
  bool get  loading=>_loading;

  Future<void> getRecommendedProductListcontrollrt()async
  {
    Response response =await recommendedProductRpo.getRecommendedProductListRepo();
    //print("you get in here ");

    if(response.statusCode==200)
      {
        print("you get in here ");
        _recommendedProductList=[];
        _recommendedProductList.addAll(Product.fromJson(response.body).products);
        _loading=true;
        update();
      }else
        {

          print("you get in errrrrrorrrrrre ,${response.statusCode.toString()}");
        }
  }
}