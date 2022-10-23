import 'package:flutter/material.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/models/address_model.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/screen/pick_address_map.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../base/show_custom_snakbar.dart';
import '../widgets/email_field_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  TextEditingController _addressController=TextEditingController();
  TextEditingController _contactPersonName=TextEditingController();
  TextEditingController _contactPersonNumber=TextEditingController();
  late bool _loggin;

  CameraPosition _cameraPosition = CameraPosition(target: LatLng(45.165123159541512,-122.18817452341318),zoom: 30);
  late LatLng _initialPosition=LatLng(45.165123159541512,-122.18817452341318);

  @override
  void initState()
  {
    super.initState();
    print(Get.find<LocationController>().addressList);

    _loggin=Get.find<AuthController>().checkToken();

    if(_loggin&&Get.find<UserController>().usermodel==null)
      {
        Get.find<UserController>().getDataInfo();
      }
    if(Get.find<LocationController>().addressList.isNotEmpty)
      {
        if(Get.find<LocationController>().getAddressFromLocalStorage()=="")
          {
            Get.find<LocationController>().saveAddress(Get.find<LocationController>().addressList.last);
          }
        Get.find<LocationController>().getUserAddress();
        _cameraPosition=CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
        ));
        _initialPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
      }
    print("______________________________________________________________");
    print("the placemark is :${Get.find<LocationController>().placemark}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address",style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder:(userController) {
        if(userController.usermodel!=null&&_contactPersonName.text.isEmpty)
          {
            _contactPersonName.text = userController.usermodel.name;
            _contactPersonNumber.text = userController.usermodel.phone;
            if(Get.find<LocationController>().addressList.isNotEmpty)
              {
                Get.find<LocationController>().getUserAddress().address;
              }
          }

        return GetBuilder<LocationController>(builder: (locationcontroller) {
          _addressController.text = '${locationcontroller.placemark.name?? ' '}'
              '${locationcontroller.placemark.locality?? ' '}'
              '${locationcontroller.placemark.postalCode?? ' '}'
              '${locationcontroller.placemark.country?? ' '}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensions.height20,horizontal: Dimensions.width10),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height20,horizontal: Dimensions.width10),
                  height: Dimensions.height70*2.5,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    border: Border.all(width: 3,color: AppColors.mainColor),
                  ),
                  child: Stack(

                    children: [
                      GoogleMap(
                        onTap: (latlang){
                          Get.toNamed(RoutesHelper.getPickAddress(
                          ),arguments: PickAddressMap(
                              fromSignUp: false,
                              fromAddress: true,
                          googleMapController:locationcontroller.mapController ,));
                        },
                        initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17),
                        zoomControlsEnabled:false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: ()
                        {
                          print("map is endind");

                          locationcontroller.updatePosition(_cameraPosition,true);
                        },
                        onCameraMove: ((position)=>
                        _cameraPosition=position
                            // print("position is :::::::::::::;"+position.toString());
                        ),
                        onMapCreated: (GoogleMapController mapController){
                          locationcontroller.setMapController(mapController);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),

                SizedBox(height: Dimensions.height35,child:Padding(
                  padding: EdgeInsets.only(left: Dimensions.width35),
                  child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: locationcontroller.addressTypeList.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: ()
                      {
                        locationcontroller.setAddressTypeIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: Dimensions.width10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20/3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 1,
                              offset: Offset(1,2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Icon(
                          index==0?Icons.home:index==1?Icons.shopping_bag:Icons.place,
                          color: locationcontroller.addressTypeindex==index?AppColors.mainColor:Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width35),child: CustomText(text: "Delivery Address")),
                SizedBox(height: Dimensions.height10,),
                TextFromField(textControll: _addressController, text: "", icon: Icons.place),

                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width35),child: CustomText(text: "Name")),
                SizedBox(height: Dimensions.height10,),
                TextFromField(textControll: _contactPersonName, text: "", icon: Icons.person),

                SizedBox(height: Dimensions.height20,),
                Padding(padding: EdgeInsets.only(left: Dimensions.width35),child: CustomText(text: "Phone")),
                SizedBox(height: Dimensions.height10,),
                TextFromField(textControll: _contactPersonNumber, text: "", icon: Icons.phone),

              ],
            ),
          );
        },);},),
      bottomNavigationBar:GetBuilder<LocationController>(builder: (locationcontroller) {
        return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              padding: EdgeInsets.only(bottom: Dimensions.height30,top: Dimensions.height10,right: Dimensions.width15,left: Dimensions.width15,),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: GestureDetector(onTap: (){
               AddressModel addressModel=AddressModel(
                 addressType:locationcontroller.addressTypeList[locationcontroller.addressTypeindex],
                 contactPersonName: _contactPersonName.text,
                 contactPersonNumber:_contactPersonNumber.text,
                 address:_addressController.text,
                 latitude: locationcontroller.position.latitude.toString(),
                 longitude: locationcontroller.position.longitude.toString(),
               );
               locationcontroller.addAddress(addressModel).then((value){
                 if(value.isSuccsessed)
                   {
                     Get.offNamed(RoutesHelper.getHomeFood());
                     ShowSnakBar(value.message,title: "Message",color: AppColors.mainColor);
                   }else
                     {
                       ShowSnakBar(value.message);
                     }
               });
              },
                child: Container(
                  padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: CustomText(text: "Save Address",sizetext: Dimensions.font20,textColor: Colors.white,),
                ),
              ),
            ),
          ],
        );
      },),


    );
  }

}
