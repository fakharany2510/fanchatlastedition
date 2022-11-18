import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isEdit = false;

class EditCover extends StatefulWidget {
  const EditCover({super.key});

  @override
  State<EditCover> createState() => _EditCoverState();
}

class _EditCoverState extends State<EditCover> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {}
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: customAppbar('Edit Profile', context),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    cubit.getCoverImage().then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                            image: cubit.coverImage == null
                                ? NetworkImage('${cubit.userModel!.cover}')
                                : cubit.cover,
                            fit: BoxFit.cover)),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TextButton(
                    //     onPressed: (){
                    //       cubit.getCoverImage().then((value) {
                    //         setState(() {
                    //         });
                    //       });
                    //     },
                    //     child:  Text('Edit Cover',style: TextStyle(
                    //         color: AppColors.primaryColor1,
                    //         fontFamily: AppStrings.appFont,
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 18
                    //     ),),
                    // ),
                    // SizedBox(width: 15,),
                    if (cubit.coverImage != null)
                      state is GetCoverImageLoadingState ||
                              state is UpdateUserLoadingState
                          ? CircularProgressIndicator(
                              color: AppColors.primaryColor1,
                            )
                          : TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    color: AppColors.primaryColor1,
                                    fontFamily: AppStrings.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
