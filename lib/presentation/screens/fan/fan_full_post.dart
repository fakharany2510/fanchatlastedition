// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/user_profile.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';

class FanFullPost extends StatelessWidget {
  FanFullPost(
      {super.key, this.image, this.userImage, this.userName, this.userId});
  String? image;
  String? userName;
  String? userImage;
  String? userId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              AppCubit.get(context)
                                  .getUserProfilePosts(id: '$userId')
                                  .then((value) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return UserProfile(
                                    userId: '$userId',
                                    userImage: '$userImage',
                                    userName: '$userName',
                                  );
                                }));
                              });
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                '$userImage',
                              ),
                              radius: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$userName',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColors.primaryColor1,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppStrings.appFont),
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
                    const SizedBox(height: 20),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          cacheManager: AppCubit.get(context).manager,
                          imageUrl: "$image",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    )
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
