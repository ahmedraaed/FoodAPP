import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/models/address_model.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo
{

  ApiClient apiClient;

  SharedPreferences sharedPreferences;

  LocationRepo({required this.sharedPreferences,required this.apiClient});

  Future<Response> getAddressFromGeoCode(LatLng latLng)async {

    print(latLng.latitude);
    print(latLng.longitude );
    return await apiClient.getData('${AppConstant.GeoCode_Uri}'+
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstant.User_Address)??"not hav";
  }


  Future<Response> addAddress(AddressModel addressModel)
  async {
    return await apiClient.postData(AppConstant.Add_User_Address,addressModel.toJson());
  }

  Future<Response> getUserList(AddressModel addressModel)
  async {
    return await apiClient.getData(AppConstant.get_user_list);
  }

  Future<bool> saveUserAddress(String userAddress)
  async {
    apiClient.updateHeaders(sharedPreferences.getString(AppConstant.Token)!);
    return await sharedPreferences.setString(AppConstant.User_Address, userAddress);
  }

}