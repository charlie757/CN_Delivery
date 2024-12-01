import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/image_picker_service.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/signup_provider.dart';
import 'package:cn_delivery/provider/vehicle_info_provider.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:cn_delivery/utils/upper_case.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/appcolor.dart';
import '../../helper/fontfamily.dart';
import '../../helper/getText.dart';
import '../../helper/screensize.dart';
import '../../helper/rectangle_textfield.dart';
import '../../utils/utils.dart';
import '../../widget/customradio.dart';
import '../../widget/image_bottom_sheet.dart';
import '../../widget/upload_image_widget.dart';
import 'package:image_picker/image_picker.dart';

class VechileInfoScreen extends StatefulWidget {
  final String route;
  const VechileInfoScreen({required this.route});

  @override
  State<VechileInfoScreen> createState() => _VechileInfoScreenState();
}

class _VechileInfoScreenState extends State<VechileInfoScreen> {
  int vehicleType = -1;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callInitFunctions();
    super.initState();
  }

  callInitFunctions(){
    final provider = Provider.of<VehicleInfoProvider>(context,listen: false);
    provider.clearValues();
  }

  checkValidation() {
    final provider = Provider.of<VehicleInfoProvider>(context, listen: false);
    if (formKey.currentState!.validate()) {
       if(provider.vehicleImage==null||provider.vehicleImage2==null||provider.licenceImage==null||provider.insuranceCopyImage==null||provider.inspectionImage==null||provider.criminalRecordImage==null){
      Utils.errorSnackBar(
          getTranslated('upload_all_images', context)!, context);  
    }
    else{
      provider.bikeCarVehicleApiFunction(widget.route==VehicleType.bike.name?'motorcycle':"car");
    }
    }
  }

  checkBiyCycleValidation(){
     final provider = Provider.of<VehicleInfoProvider>(context, listen: false);
    if (formKey.currentState!.validate()) {
       if(provider.vehicleImage==null){
      Utils.errorSnackBar(
          getTranslated('upload_vehicle_image', context)!, context);  
    }
    else{
      provider.bicycleVehicleApiFunction();
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleInfoProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(
            title: getTranslated('vehicle_information', context)!,
            isLeading: true),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.route==VehicleType.bicycle.name?
                biCycleWidget(myProvider):carAndBikeWidget(myProvider),
                ScreenSize.height(30),
                AppButton(
                    title: getTranslated('continue', context)!,
                    height: 56,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    onTap: () {
                      widget.route == VehicleType.bicycle.name?
                      checkBiyCycleValidation():
                      checkValidation();
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  showBottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getText(
                          title: getTranslated('select_vehicle_type', context)!,
                          size: 18,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                  ScreenSize.height(20),
                  ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(10);
                      },
                      itemCount: Constants.vehicleTypeList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            vehicleType = index;
                            Provider.of<SignupProvider>(context, listen: false)
                                .vehicleTypeController
                                .text = Constants.vehicleTypeList[index];
                            Navigator.pop(context);
                            state(() {});
                          },
                          child: Container(
                            color: AppColor.whiteColor,
                            height: 30,
                            child: Row(
                              children: [
                                customRadio(index, vehicleType),
                                ScreenSize.width(15),
                                getText(
                                    title: Constants.vehicleTypeList[index],
                                    size: 16,
                                    fontFamily: FontFamily.nunitoMedium,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          });
        });
  }

biCycleWidget(VehicleInfoProvider myProvider){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       getText(
            title: getTranslated('vehicleBrand', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_brand_name', context)!,
          controller: myProvider.vehicleBrandController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_brand_name', context)!;
            }
          },
        ),
        ScreenSize.height(15),
          getText(
            title: getTranslated('vehicle_size', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_vehicle_size', context)!,
          controller: myProvider.vehicleSizeController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_vehicle_size', context)!;
            }
          },
        ),
        ScreenSize.height(15),
          getText(
            title: getTranslated('vehicle_color', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_vehicle_color', context)!,
          controller: myProvider.vehicleColorController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_vehicle_color', context)!;
            }
          },
        ),
        ScreenSize.height(15),
         getText(
            title: getTranslated('vehicle_image', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(
            onTap: () {
              imageBottomSheet(context, cameraTap: () {
                ImagePickerService.imagePicker(context, ImageSource.camera).then((val) {
                  if (val != null) {
                    myProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              }, galleryTap: () {
                ImagePickerService
                    .imagePicker(context, ImageSource.gallery)
                    .then((val) {
                  if (val != null) {
                    myProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              });
            },
            imgPath: myProvider.vehicleImage),
      
    ],
  );
}

  carAndBikeWidget(VehicleInfoProvider myProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(
            title: getTranslated('vehicle_name', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_vehicle_name', context)!,
          controller: myProvider.vehicleNameController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_vehicle_name', context)!;
            }
          },
        ),
        ScreenSize.height(15),
        getText(
            title: getTranslated('vehicleBrand', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_brand_name', context)!,
          controller: myProvider.vehicleBrandController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_brand_name', context)!;
            }
          },
        ),
        ScreenSize.height(15),
        getText(
            title: getTranslated('model_number', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_model_number', context)!,
          controller: myProvider.modelNumberController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_model_number', context)!;
            }
          },
        ),
        ScreenSize.height(15),
        getText(
            title: getTranslated('date_of_registration', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('select_registration_date', context)!,
          controller: myProvider.dorController,
          textInputAction: TextInputAction.next,
          onTap: () {
            myProvider.datePicker(myProvider.selectedDORDate).then((val) {
              if (val != null) {
                myProvider.selectedDORDate = val;
                myProvider.dorController.text =
                    "${val.day.toString().length == 1 ? "0${val.day}" : val.day}-${val.month.toString().length == 1 ? "0${val.month}" : val.month}-${val.year}";
              }
            });
          },
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('select_registration_date', context)!;
            }
          },
          isReadOnly: true,
          suffix: SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              Icons.date_range_rounded,
              color: AppColor.blueColor.withOpacity(.5),
            ),
          ),
        ),
        ScreenSize.height(15),
        getText(
            title: getTranslated('registration_number', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_registration_number', context)!,
          controller: myProvider.registrationController,
          textInputAction: TextInputAction.next,
          inputFormatters: [
          ],
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_registration_number', context)!;
            }
          },
        ),
        ScreenSize.height(15),
        getText(
            title: getTranslated('licence_number', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        RectangleTextfield(
          hintText: getTranslated('enter_licence_number', context)!,
          controller: myProvider.licenceController,
          textInputAction: TextInputAction.done,
          inputFormatters: [UpperCaseTextFormatter()],
          validator: (val) {
            if (val.isEmpty) {
              return getTranslated('enter_licence_number', context)!;
            }
          },
        ),
        ScreenSize.height(15),
       Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                getText(
            title: "${getTranslated('vehicle_image', context)!}-1",
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(
            onTap: () {
              imageBottomSheet(context, cameraTap: () {
                ImagePickerService.imagePicker(context, ImageSource.camera).then((val) {
                  if (val != null) {
                    myProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              }, galleryTap: () {
                ImagePickerService
                    .imagePicker(context, ImageSource.gallery)
                    .then((val) {
                  if (val != null) {
                    myProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              });
            },
            imgPath: myProvider.vehicleImage),
            ],
          )),
          ScreenSize.width(15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                getText(
            title: "${getTranslated('vehicle_image', context)!}-2",
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    ImagePickerService.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.vehicleImage2 = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    ImagePickerService.imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        myProvider.vehicleImage2 = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath:myProvider.vehicleImage2),
                    ],
          ))
        ],
       ),
    ScreenSize.height(15),
    
       Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                getText(
            title: getTranslated('licence_image', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(
            onTap: () {
              imageBottomSheet(context, cameraTap: () {
                ImagePickerService.imagePicker(context, ImageSource.camera).then((val) {
                  if (val != null) {
                    myProvider.licenceImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              }, galleryTap: () {
                ImagePickerService
                    .imagePicker(context, ImageSource.gallery)
                    .then((val) {
                  if (val != null) {
                    myProvider.licenceImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              });
            },
            imgPath: myProvider.licenceImage),
            ],
          )),
          ScreenSize.width(15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                getText(
            title: getTranslated('insurance_copy', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    ImagePickerService.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.insuranceCopyImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    ImagePickerService.imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        myProvider.insuranceCopyImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath:myProvider.insuranceCopyImage),
                    ],
          ))
        ],
       ),
    ScreenSize.height(15),
       Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(
            title: getTranslated('inspection_certificate', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(
            onTap: () {
              imageBottomSheet(context, cameraTap: () {
                ImagePickerService.imagePicker(context, ImageSource.camera).then((val) {
                  if (val != null) {
                    myProvider.inspectionImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              }, galleryTap: () {
                ImagePickerService
                    .imagePicker(context, ImageSource.gallery)
                    .then((val) {
                  if (val != null) {
                    myProvider.inspectionImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              });
            },
            imgPath: myProvider.inspectionImage),
            ],
          )),
          ScreenSize.width(15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                getText(
            title: getTranslated('ceriminal_record_certificate', context)!,
            size: 12,
            maxLies: 1,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                     ImagePickerService.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.criminalRecordImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    ImagePickerService.imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        myProvider.criminalRecordImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath:myProvider.criminalRecordImage),
                    ],
          ))
        ],
       ),
    
      ],
    );
  }
}
