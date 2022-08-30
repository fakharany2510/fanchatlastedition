import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';

class FanFullPost extends StatelessWidget {

  FanFullPost({Key? key,this.image,this.userImage,this.userName}) : super(key: key);
  String ?image;
  String ?userName;
  String ?userImage;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${userImage}',
                        ),
                        radius: 18,
                      ),
                      const SizedBox(width: 7,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text('${userName}',
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppStrings.appFont
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      // IconButton(
                      //   onPressed: (){},
                      //   padding: EdgeInsets.zero,
                      //   constraints: BoxConstraints(),
                      //   icon:Icon(Icons.favorite_outline,color: AppColors.navBarActiveIcon,size: 20),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child:  CachedNetworkImage(
                          cacheManager: AppCubit.get(context).manager,
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
