import 'package:flutter/material.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key, required this.fromSignUp, required this.fromAddress, this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _intialPosition;
  late CameraPosition _cameraPosition;
  late GoogleMapController googleMapController;

  @override
  initState()
  {
   super.initState();
   if(Get.find<LocationController>().addressList.isEmpty)
     {
       _intialPosition=LatLng(45, -122);
       _cameraPosition=CameraPosition(target: _intialPosition,zoom: 17);

     }else
       {
         if(Get.find<LocationController>().addressList.isEmpty)
           {
             _intialPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),Get.find<LocationController>().getAddress["longitude"]);
             _cameraPosition=CameraPosition(target: _intialPosition,zoom: 5);
           }
       }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body:SafeArea(
          child: Center(
            child: SizedBox(width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target:_intialPosition,zoom: 5),
                    zoomControlsEnabled: false,
                    indoorViewEnabled: false,
                    onCameraMove:(CameraPosition cameraPosition ){
                      _cameraPosition=cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition,false);
                    },
                  ),
                  Center(
                    child:!locationController.isloading? Image.asset("assats/image/pick_marker.png",
                      width:Dimensions.width35+10,
                      height: Dimensions.height35+10,):Center(child: CircularProgressIndicator(),),
                  ),
                  Positioned(
                    top:Dimensions.height55,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width5),
                      height: Dimensions.height55,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add_location,color: Colors.yellow,size: Dimensions.iconSize30),
                          Expanded(child: Text("${locationController.pickPlacemark.name??""}",
                            style: TextStyle(color: Colors.white,fontSize: Dimensions.font20-2,),
                            maxLines: 1,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: Dimensions.height70,
                  right: Dimensions.width20*4,
                  left: Dimensions.width20*4,
                  child: CustomButton(buttonText: 'Save Address',onPressed:locationController.isloading?null:
                   () {
                    if (locationController.pickPosition.latitude!=0&&locationController.pickPlacemark.name!=null)
                      {
                        if(widget.fromAddress)
                          {
                            if(widget.googleMapController!=null)
                              {
                                print("now you can click on this ");
                                widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target:
                                LatLng(locationController.pickPosition.latitude, locationController.pickPosition.longitude))));
                                locationController.setAddressData();
                              }
                            Get.toNamed(RoutesHelper.getAddAddress());
                          }
                      }
                  },
                  ),
                  ),
                ],
              ),),
          ),
        ),
      );
    },);
  }
}
