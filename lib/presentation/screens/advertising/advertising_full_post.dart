// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisingFullPost extends StatelessWidget {
  AdvertisingFullPost({
    super.key,
    this.image,
    this.imageLink,
  });
  String? image;
  String? imageLink;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvertisingCubit, AdvertisingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppbar('fan Post', context),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        cacheManager: AdvertisingCubit.get(context).manager,
                        imageUrl: "$image",
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
