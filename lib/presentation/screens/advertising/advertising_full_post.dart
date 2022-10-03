import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';

class AdvertisingFullPost extends StatelessWidget {

  AdvertisingFullPost({Key? key,this.image,this.imageLink,}) : super(key: key);
  String ?image;
  String ?imageLink;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvertisingCubit , AdvertisingState>(
      listener: (context,state){

      },
      builder: (context , state){
        return Scaffold(
          backgroundColor:Colors.white,
          appBar: customAppbar('fan Post',context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                SizedBox(height: 20,),
                Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child:  CachedNetworkImage(
                        cacheManager: AdvertisingCubit.get(context).manager,
                        imageUrl: "${image}",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      ),
                    )
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
