import 'package:foodapp/data/reposetry/auth_repo.dart';
import 'package:foodapp/models/response_model.dart';
import 'package:foodapp/models/sgin_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService
{
  AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isload = false;
  bool get isload => _isload;

  Future<ResponseModel> Regestration(SignUpBody signUpBody)async
  {
    _isload=true;
    update();
    Response response=await authRepo.registeration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200)
      {
        print("your data will upload");
        authRepo.saveToken(response.body["token"]);
        print("token is :"+ response.body["token"]);
        responseModel = ResponseModel(true, response.body["token"]) ;
      }else
        {
          print("your data will not upload");

          responseModel = ResponseModel(false, response.statusText!) ;
        }
    _isload=false;
    update();
    return responseModel;
  }



  Future<ResponseModel> login(String phone,String password)async
  {
    _isload=true;
    print(authRepo.getToken().toString());
    update();
    Response response=await authRepo.Login(phone, password);
    late ResponseModel responseModel;
    if(response.statusCode==200)
    {
      print("your login is succesd");
      authRepo.saveToken(response.body["token"]);
      print("token is :"+ response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]) ;
    }else
    {
      print("your login faild");

      responseModel = ResponseModel(false, response.statusText!) ;
    }
    _isload=false;
    update();
    return responseModel;
  }
  void asveEmail(String phone,String password)
  {
    authRepo.saveEmailAndPassword(phone, password);
  }
  bool checkToken()
  {
    return authRepo.checkToken();
  }

  clear()
  {
    authRepo.clear();
  }


}