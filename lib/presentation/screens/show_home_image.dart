import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class ShowHomeImage extends StatelessWidget {
  String ?image;
  ShowHomeImage({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        child: Center(
          child:  CachedNetworkImage(
            cacheManager: AppCubit.get(context).manager,
            imageUrl: "${image}",
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            fit: BoxFit.fill,
            height: 450,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
