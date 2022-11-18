// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class ShowHomeImage extends StatelessWidget {
  String? image;
  ShowHomeImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Opacity(
              opacity: 1,
              child: Image(
                image: AssetImage('assets/images/imageback.jpg'),
                fit: BoxFit.cover,
              ),
            )),
        Center(
          child: CachedNetworkImage(
            cacheManager: AppCubit.get(context).manager,
            imageUrl: "$image",
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
      ],
    ));
  }
}
