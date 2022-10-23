import 'dart:convert';

import 'package:foodapp/data/reposetry/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';
import '../models/response_model.dart';

class LocationController extends GetxController implements GetxService
{
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _isloading=false;
  bool get isloading=>_isloading;

  late Position _position;
  late Position _pickPosition;

  Position get position=>_position;
  Position get pickPosition=>_pickPosition;


  Placemark _placemark=Placemark();
  Placemark _pickPlacemark=Placemark();

  Placemark get placemark=>_placemark;
  Placemark get pickPlacemark=>_pickPlacemark;


  List<AddressModel> _addressList=[];
  List<AddressModel> get addressList=> _addressList;

  List<AddressModel> _allAddressList=[];
  List<AddressModel> get allAddressList=> _allAddressList;


  List<String> _addressTypeList=["home","office","other"];
  List<String> get addressTypeList=>_addressTypeList;

  int _addressTypeindex=0;
  int get addressTypeindex=>_addressTypeindex;


  late Map<String,dynamic> _getAddress;
  Map<String,dynamic> get getAddress=>_getAddress;

  bool _updateAddressDate=true;
  bool get updateAddressDate=>_updateAddressDate;
  bool _changeAddress=true;
  bool get changeAddress=>_changeAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController=>_mapController;
  void setMapController(GoogleMapController mapController)
  {
    _mapController=mapController;
  }

  Future<void> updatePosition(CameraPosition caPosition, bool fromAddress) async {
    if(_updateAddressDate) {
      _isloading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: caPosition.target.longitude,
              latitude: caPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: caPosition.target.longitude,
              latitude: caPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeoCode(
              LatLng(caPosition.target.latitude, caPosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
      _isloading = false;
      update();
    }else
      {
        _updateAddressDate=true;
      }
  }

  Future<String> getAddressFromGeoCode(LatLng latLng)async {
    String _address="Not Avalibale";
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    // print("error while you get data from API  "+response.statusCode.toString());

    if(response.body["status"]=="OK")
      {

        _address=response.body["results"][0]["formatted_address"].toString();
      }else
        {
          print("error while you get data from API  ${response.statusCode}  "+response.body["status"]);

        }

    // _address=latLng.longitude.toString()+latLng.longitude.toString();
    update();
    return _address;

  }

  AddressModel getUserAddress()
  {
    late AddressModel addressModel;
    _getAddress=jsonDecode(locationRepo.getUserAddress());
    try
    {
      addressModel=AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e)
    {
      print("error when get address ");
    }
    return addressModel;
  }

  void setAddressTypeIndex(int index)
  {
    _addressTypeindex=index;
    update();
  }


  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _isloading=true;
    update();
    Response response=await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode==200)
      {
        getAddressList(addressModel);
        print("every thing is okey");
        print(response.body["message"]);
        responseModel=ResponseModel(true, response.body["message"]);
        saveAddress(addressModel);
      }else
        {
          responseModel=ResponseModel(false, response.statusText!);
        }
    // _isloading=false;
    update();
    return responseModel;
  }
  Future<void> getAddressList(AddressModel addressModel)
  async {
    Response response=await locationRepo.getUserList(addressModel);
    if(response.statusCode==200)
      {
        _addressList=[];
        _allAddressList=[];
        print(response.body);
        response.body.forEach((address)
        {
         // print("what is address"+address.toString());
          _addressList.add(AddressModel.fromJson(address));
          _allAddressList.add(AddressModel.fromJson(address));
          saveAddress(addressModel);

        });
      }else
        {
          _addressList=[];
          _allAddressList=[];
        }

    update();
  }

  Future<bool> saveAddress(AddressModel addressModel)
  async {
    String userAddress=jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  cleardata()
  {
    _addressList=[];
    _allAddressList=[];
    update();
  }
  String getAddressFromLocalStorage() {
    return  locationRepo.getUserAddress();
}

  void setAddressData()
  {
    _position=_pickPosition;
    _placemark=_pickPlacemark;
    _updateAddressDate=false;
    update();
  }
}