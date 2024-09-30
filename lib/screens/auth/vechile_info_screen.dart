import 'package:cn_delivery/helper/custom_button.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/signup_provider.dart';
import 'package:cn_delivery/screens/auth/upload_vehicle_image_screen.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/upper_case.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/approutes.dart';
import '../../helper/appbutton.dart';
import '../../helper/appcolor.dart';
import '../../helper/fontfamily.dart';
import '../../helper/getText.dart';
import '../../helper/screensize.dart';
import '../../helper/signuptextfield.dart';
import '../../utils/utils.dart';
import '../../widget/customradio.dart';
import '../../widget/image_bottom_sheet.dart';
import '../../widget/upload_image_widget.dart';
import 'package:image_picker/image_picker.dart';

class VechileInfoScreen extends StatefulWidget {
  const  VechileInfoScreen({super.key});

  @override
  State<VechileInfoScreen> createState() => _VechileInfoScreenState();
}

class _VechileInfoScreenState extends State<VechileInfoScreen> {
  int vehicleType=-1;
  int fuelType=-1;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  callInit(){
    final provider = Provider.of<SignupProvider>(context,listen: false);
  }

  checkValidation(){
    final provider = Provider.of<SignupProvider>(context,listen: false);
    if(provider.licenceImage==null){
      Utils.errorSnackBar(getTranslated('upload_license_image', context)!, context);
    }
    if(formKey.currentState!.validate()&&provider.licenceImage!=null){
      AppRoutes.pushCupertinoNavigation(const UploadVehicleImageScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          appBar: appBar(title: getTranslated('vehicle_information', context)!,isLeading: true),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding:const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     getText(title: getTranslated('vehicle_name', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('enter_vehicle_name', context)!,
                  controller: myProvider.vehicleNameController,
                    validator: (val){
                    if(val.isEmpty){
                      return getTranslated('enter_vehicle_name', context)!;
                    }
                    },
                  ),
                  ScreenSize.height(15),
                   getText(title: getTranslated('vehicle_type', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('select_vehicle_type_validation', context)!,isReadOnly: true,
                  controller: myProvider.vehicleTypeController,
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('select_vehicle_type_validation', context)!;
                      }
                    },
                  onTap: (){
                    showBottomSheet();
                  },
                  suffix:const SizedBox(
                    height: 20,width: 20,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  ),
                  ScreenSize.height(15),
                   getText(title: getTranslated('model_number', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('enter_model_number', context)!,
                  controller: myProvider.modelNumberController,
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('enter_model_number', context)!;
                      }
                    },
                  ),
                  // ScreenSize.height(15),
                  //  getText(title: getTranslated('date_of_manufacture', context)!,
                  //     size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                  //     fontWeight: FontWeight.w400),
                  // ScreenSize.height(6),
                  // SignUpTextField(hintText: getTranslated('select__manufacture_date', context)!,
                  // controller: myProvider.domController,
                  // validator: (val){
                  //   if(val.isEmpty){
                  //     return getTranslated('select__manufacture_date', context)!;
                  //   }
                  // },
                  // isReadOnly: true,onTap: (){
                  //     myProvider.datePicker(myProvider.selectedDOMDate).then((val){
                  //       print(val);
                  //       if(val!=null){
                  //         myProvider.selectedDOMDate = val;
                  //         myProvider.domController.text = "${val.day.toString().length==1?"0${val.day}":val.day}-${val.month.toString().length==1?"0${val.month}":val.month}-${val.year}";
                  //       }
                  //     });
                  //   },
                  //   suffix:  SizedBox(
                  //     height: 20,width: 20,
                  //     child: Icon(Icons.date_range_rounded,color: AppColor.blueColor.withOpacity(.5),),
                  //   ),
                  // ),
                  ScreenSize.height(15),
                   getText(title: getTranslated('date_of_registration', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('select_registration_date', context)!,
                  controller: myProvider.dorController,
                    onTap: (){
                      myProvider.datePicker(myProvider.selectedDORDate).then((val){
                        if(val!=null){
                          myProvider.selectedDORDate = val;
                          myProvider.dorController.text = "${val.day.toString().length==1?"0${val.day}":val.day}-${val.month.toString().length==1?"0${val.month}":val.month}-${val.year}";
                        }
                      });
                    },
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('select_registration_date', context)!;
                      }
                    },
                  isReadOnly: true, suffix:  SizedBox(
                      height: 20,width: 20,
                      child: Icon(Icons.date_range_rounded,color: AppColor.blueColor.withOpacity(.5),),
                    ),
                  ),
                  ScreenSize.height(15),

                   getText(title: getTranslated('fuel_type', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('select_fuel_type_validation', context)!,isReadOnly: true,
                    controller: myProvider.fuelController,
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('select_fuel_type_validation', context)!;
                      }
                    },
                    onTap: (){
                      fuelTypeBottomSheet();
                    },
                    suffix:const SizedBox(
                    height: 20,width: 20,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  ),
                  ScreenSize.height(15),
                  getText(title: getTranslated('registration_number', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('enter_registration_number', context)!,
                    controller: myProvider.registrationController,
                    inputFormatters: [
                      // UpperCaseTextFormatter()
                    ],
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('enter_registration_number', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                   getText(title: getTranslated('licence_number', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  SignUpTextField(hintText: getTranslated('enter_licence_number', context)!,
                  controller: myProvider.licenceController,
                    inputFormatters: [
                      UpperCaseTextFormatter()
                    ],
                    validator: (val){
                      if(val.isEmpty){
                        return getTranslated('enter_licence_number', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                   getText(title: getTranslated('licence_image', context)!,
                      size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  uploadImageWidget(onTap: (){
                    imageBottomSheet(context,cameraTap: (){
                      myProvider.imagePicker(context, ImageSource.camera).then((val){
                        if(val!=null){
                          myProvider.licenceImage = val;
                          setState(() {

                          });
                          Navigator.pop(context);
                        }
                      });
                    },galleryTap: (){
                      myProvider.imagePicker(context, ImageSource.gallery).then((val){
                        if(val!=null){
                          myProvider.licenceImage = val;
                          setState(() {
                          });
                          Navigator.pop(context);
                        }
                      });
                    });
                  }, imgPath: myProvider.licenceImage),
                  ScreenSize.height(25),
                  CustomButton(title: getTranslated('next', context)!,
                      height: 50, width: double.infinity, buttonColor: AppColor.blueColor,
                      onTap: (){
                        checkValidation();
                      })
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  showBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,state) {
                return Container(
                  padding:const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: getTranslated('select_vehicle_type', context)!, size: 18,
                              fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const Icon(Icons.close),)
                        ],
                      ),
                      ScreenSize.height(20),
                      ListView.separated(
                        separatorBuilder: (context,sp){
                          return ScreenSize.height(10);
                        },
                          itemCount: Constants.vehicleTypeList.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            vehicleType =index;
                            Provider.of<SignupProvider>(context,listen: false).vehicleTypeController.text= Constants.vehicleTypeList[index];
                            Navigator.pop(context);
                            state(() {

                            });
                          },
                          child: Container(
                            color: AppColor.whiteColor,
                            height: 30,
                            child: Row(
                              children: [
                                customRadio(index,vehicleType),
                                ScreenSize.width(15),
                                getText(title: Constants.vehicleTypeList[index], size: 16,
                                    fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }
          );
        });
  }


  fuelTypeBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,state) {
                return Container(
                  padding:const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: getTranslated('select_fuel_type', context)!, size: 18,
                              fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const Icon(Icons.close),)
                        ],
                      ),
                      ScreenSize.height(20),
                      GestureDetector(
                        onTap: (){
                          fuelType =0;
                          Provider.of<SignupProvider>(context,listen: false).fuelController.text = 'Petrol';
                          Navigator.pop(context);
                          state(() {

                          });
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(0,fuelType),
                              ScreenSize.width(15),
                              getText(title: getTranslated('petrol', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                      ScreenSize.height(10),
                      GestureDetector(
                        onTap: (){
                          fuelType=1;
                              Provider.of<SignupProvider>(context,listen: false).fuelController.text = 'Diesel';
                          state(() {
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(1,fuelType),
                              ScreenSize.width(15),
                              getText(title: getTranslated('diesel', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }


}
