// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImagehelper extends StatelessWidget {
  final img;
  final height;
  final width;
  const NetworkImagehelper({super.key, this.img, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              color: AppColor.appTheme,
              strokeWidth: 2,
              value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    // Image.network(
    //   img,
    //   height: height,
    //   width: width,
    //   fit: BoxFit.fill,

    //   loadingBuilder: (BuildContext context, Widget child,
    //       ImageChunkEvent? loadingProgress) {
    //     if (loadingProgress == null) return child;
    //     return Center(
    //       child: CircularProgressIndicator(
    //         color: AppColor.appTheme,
    //         // value: loadingProgress.expectedTotalBytes != null
    //         //     ? loadingProgress.cumulativeBytesLoaded /
    //         //         loadingProgress.expectedTotalBytes!
    //         //     : null,
    //       ),
    //     );
    //   },
    // );
  }
}
