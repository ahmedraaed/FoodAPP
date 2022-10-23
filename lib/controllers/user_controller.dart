import 'package:foodapp/data/reposetry/user_repo.dart';
import 'package:foodapp/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService
{
  UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isloading=false;
  bool get isloading=>_isloading;

  late UserModel _userModel;
  UserModel get usermodel=>_userModel;

  Future<ResponseModel> getDataInfo()async
  {
    Response response = await userRepo.getDatainfo();
    late ResponseModel responseModel;

    if(response.statusCode==200)
      {
        print("your are login innininninini22222222222222222222222222");
        _userModel=UserModel.fromJson(response.body);
        _isloading=true;
        responseModel = ResponseModel(true, "success") ;
      }else
        {
          print("your are login innininninini3333333333333333333333"+response.statusText.toString());

          responseModel = ResponseModel(true, response.statusText!) ;
        }
    update();
    return responseModel;
  }
}