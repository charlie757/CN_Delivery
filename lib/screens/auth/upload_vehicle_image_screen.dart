import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/appcolor.dart';
import '../../helper/fontfamily.dart';
import '../../helper/getText.dart';
import '../../helper/screensize.dart';
import '../../helper/custom_button.dart';
import '../../provider/signup_provider.dart';
import '../../utils/utils.dart';
import '../../widget/appBar.dart';
import '../../widget/image_bottom_sheet.dart';
import '../../widget/upload_image_widget.dart';
import 'package:image_picker/image_picker.dart';

class UploadVehicleImageScreen extends StatefulWidget {
  const UploadVehicleImageScreen({super.key});

  @override
  State<UploadVehicleImageScreen> createState() => _UploadVehicleImageScreenState();
}

class _UploadVehicleImageScreenState extends State<UploadVehicleImageScreen> {

  checkValidation(){
    final provider = Provider.of<SignupProvider>(context,listen: false);
    if(provider.insuranceCopyImage==null){
      Utils.errorSnackBar(getTranslated('upload_insurance_copy_image', context)!, context);
    }
    else if(provider.touristPermitImage==null){
      Utils.errorSnackBar(getTranslated('upload_tourist_image', context)!, context);
    }
    else if(provider.vehicleImage==null){
      Utils.errorSnackBar(getTranslated('upload_vehicle_image', context)!, context);
    }
    else {
      provider.callApiFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pop(context);
    return Scaffold(
      appBar: appBar(title: getTranslated('upload_vehicle_documents', context)!,isLeading: true),
      body: Consumer<SignupProvider>(
        builder: (context,myProvider,child) {
          return SingleChildScrollView(
            padding:const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 getText(title: getTranslated('insurance_copy', context)!,
                    size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(6),
                uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    myProvider.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.insuranceCopyImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    myProvider.imagePicker(context, ImageSource.gallery).then((val){
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
                ScreenSize.height(15),
                 getText(title: getTranslated('tourist_permit', context)!,
                    size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(6),
                uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    myProvider.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.touristPermitImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    myProvider.imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        myProvider.touristPermitImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });

                },
                    imgPath:myProvider.touristPermitImage),
                ScreenSize.height(15),
                 getText(title: getTranslated('vehicle_image', context)!,
                    size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(6),
                uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    myProvider.imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        myProvider.vehicleImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    myProvider.imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        myProvider.vehicleImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath: myProvider.vehicleImage),
                ScreenSize.height(25),

              ],
            ),
          );
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
        child: CustomButton(title: getTranslated('continue', context)!,
            height: 50, width: double.infinity, buttonColor: AppColor.blueColor,
            onTap: (){
              checkValidation();
            }),
      ),
    );
  }


}
