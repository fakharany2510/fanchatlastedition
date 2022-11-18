// ignore_for_file: unused_element

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/edit_profile/edit_cover.dart';
import 'package:fanchat/presentation/screens/edit_profile/edit_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetProfileImageFirstTimeSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const EditImage();
          }));
        }

        if (state is GetCoverImageFirstTimeSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const EditCover();
          }));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            backgroundColor: AppColors.primaryColor1,
            appBar: customAppbar('Edit Profile', context),
            body: Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Opacity(
                      opacity: 1,
                      child: Image(
                        image:
                            AssetImage('assets/images/public_chat_image.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    )),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is GetCoverImageLoadingState ||
                          state is GetProfileImageLoadingState)
                        const LinearProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SizedBox(
                          height: 200,
                          child: Stack(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: DecorationImage(
                                              image: cubit.coverImage == null
                                                  ? NetworkImage(
                                                      '${cubit.userModel!.cover}')
                                                  : cubit.cover,
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.myGrey,
                                        radius: 20,
                                        child: IconButton(
                                            onPressed: () {
                                              // isEdit=false;
                                              cubit.getCoverImageFirstTime();
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              color: AppColors.primaryColor1,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 57,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          cubit.profileImage == null
                                              ? NetworkImage(
                                                  '${cubit.userModel!.image}')
                                              : cubit.profile,
                                      radius: 55,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.myGrey,
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.getProfileImageFirstTime(context);
                                        // print('change personal photo');
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColors.primaryColor1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // if (AppCubit.get(context).profileImage != null ||
                      //     AppCubit.get(context).coverImage != null)
                      //   Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 10),
                      //     child: Row(
                      //       children: [
                      //         if (cubit.profileImage != null)
                      //           Expanded(
                      //             child: Column(
                      //               children: [
                      //                 defaultButton(
                      //                   textColor: AppColors.primaryColor1,
                      //                   width: size.width * .6,
                      //                   height: size.height * .06,
                      //                   fontSize: 14,
                      //                   buttonColor: AppColors.myGrey,
                      //                   buttonText: 'Upload profile image',
                      //                   function: () {
                      //                     // cubit
                      //                     //     .uploadUserImage(
                      //                     //   name: cubit.changeUserNameController.text,
                      //                     //   phone:
                      //                     //       cubit.changeUserPhoneController.text,
                      //                     //   bio: cubit.changeUserBioController.text,
                      //                     // )
                      //                     //     .then((value) {
                      //                     //   cubit.getUser();
                      //                     // });
                      //                   },
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         SizedBox(width: 5),
                      //         if (cubit.coverImage != null)
                      //           Expanded(
                      //             child: Column(
                      //               children: [
                      //                 defaultButton(
                      //                   textColor: AppColors.primaryColor1,
                      //                   width: size.width * .6,
                      //                   height: size.height * .06,
                      //                   fontSize: 14,
                      //                   buttonColor: AppColors.myGrey,
                      //                   buttonText: 'Upload cover image',
                      //                   function: () {
                      //                     // cubit
                      //                     //     .uploadUserCover(
                      //                     //   name: cubit.changeUserNameController.text,
                      //                     //   phone:
                      //                     //       cubit.changeUserPhoneController.text,
                      //                     //   bio: cubit.changeUserBioController.text,
                      //                     // )
                      //                     //     .then((value) {
                      //                     //   cubit.getUser();
                      //                     // });
                      //                   },
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //   ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                            context: context,
                            controller: cubit.changeUserNameController,
                            errorMessage: "please enter your name",
                            inputType: TextInputType.name,
                            labelText: "Name",
                            prefixIcon:
                                Icon(Icons.person, color: AppColors.myGrey)),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      //   child: textFormFieldWidget(
                      //       context: context,
                      //       controller: cubit.changeUserPhoneController,
                      //       errorMessage: "please enter your phone",
                      //       inputType: TextInputType.phone,
                      //       labelText: "phone",
                      //       prefixIcon: Icon(Icons.phone, color: AppColors.myGrey)),
                      // ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                          maxLines: 4,
                          context: context,
                          controller: cubit.changeUserBioController,
                          errorMessage: "please enter your bio",
                          inputType: TextInputType.text,
                          labelText: "Bio",
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                            context: context,
                            controller: cubit.changeYoutubeLinkController,
                            errorMessage: "please enter your youtube link",
                            inputType: TextInputType.text,
                            labelText: "Enter Youtube Link",
                            prefixIcon: Container(
                              height: 5,
                              width: 5,
                              margin: const EdgeInsets.all(12),
                              child: const Image(
                                  image:
                                      AssetImage('assets/images/youtube.png')),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                            context: context,
                            controller: cubit.changeFacebookLinkController,
                            errorMessage: "please enter your facebook link",
                            inputType: TextInputType.text,
                            labelText: "Enter Facebook Link",
                            prefixIcon: Container(
                              height: 5,
                              width: 5,
                              margin: const EdgeInsets.all(12),
                              child: const Image(
                                  image:
                                      AssetImage('assets/images/facebook.png')),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                            context: context,
                            controller: cubit.changeTwitterLinkController,
                            errorMessage: "please enter your twitter link",
                            inputType: TextInputType.text,
                            labelText: "Enter Twitter Link",
                            prefixIcon: Container(
                              height: 5,
                              width: 5,
                              margin: const EdgeInsets.all(12),
                              child: const Image(
                                  image:
                                      AssetImage('assets/images/twitter.png')),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textFormFieldWidget(
                          context: context,
                          controller: cubit.changeInstagramLinkController,
                          errorMessage: "please enter your instagram link",
                          inputType: TextInputType.text,
                          labelText: "Enter Instagram Link",
                          prefixIcon: Container(
                            height: 5,
                            width: 5,
                            margin: const EdgeInsets.all(12),
                            child: const Image(
                                image:
                                    AssetImage('assets/images/instagram.png')),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 25),
                      //     child: Text("Select Favorite Team :",style: TextStyle(
                      //         color: AppColors.myGrey,
                      //         fontSize: 16,
                      //         fontFamily: AppStrings.appFont
                      //     ),),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(
                      //       horizontal: 15
                      //     ),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: AppColors.myWhite,
                      //         width: 1
                      //       ),
                      //       borderRadius: BorderRadius.circular(20)
                      //     ),
                      //     child: CountryPickerDropdown(
                      //       dropdownColor: AppColors.primaryColor1,
                      //       initialValue: CashHelper.getData(key: 'isoCode')==null? 'QA':CashHelper.getData(key: 'isoCode'),
                      //       itemBuilder: _buildDropdownItem,
                      //       priorityList:[
                      //         CountryPickerUtils.getCountryByIsoCode('GB'),
                      //         CountryPickerUtils.getCountryByIsoCode('CN'),
                      //       ],
                      //       sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                      //       onValuePicked: (Country country) {
                      //         print("${country.isoCode}");
                      //         printMessage("+${country.phoneCode}");
                      //         CashHelper.saveData(key: 'isoCode',value:"${country.isoCode}" );
                      //
                      //         CashHelper.saveData(key: 'Team',value:"${country.name}" );
                      //       },
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(height: 30),
                      state is UpdateUserLoadingState ||
                              state is GetCoverImageSuccessState ||
                              state is GetProfileImageSuccessState
                          ? const CircularProgressIndicator()
                          : defaultButton(
                              textColor: AppColors.myWhite,
                              buttonText: 'Save Changes',
                              buttonColor: const Color(0Xffd32330),
                              height: size.height * .06,
                              width: size.width * .9,
                              function: () {
                                if (cubit.changeUserNameController.text != '') {
                                  if (cubit.coverImage != null) {
                                    cubit
                                        .uploadUserCover(
                                      name: cubit.changeUserNameController.text,
                                      bio: cubit.changeUserBioController.text,
                                    )
                                        .then((value) {
                                      customToast(
                                          title: 'Data Updated',
                                          color: AppColors.primaryColor1);
                                    });
                                  }

                                  //////////////////////////////////
                                  if (cubit.profileImage != null) {
                                    cubit
                                        .uploadUserImage(
                                      name: cubit.changeUserNameController.text,
                                      bio: cubit.changeUserBioController.text,
                                    )
                                        .then((value) {
                                      customToast(
                                          title: 'Data Updated',
                                          color: AppColors.primaryColor1);
                                    });
                                  }

                                  ///////////////////////////
                                  cubit
                                      .updateProfile(
                                    image: cubit.profilePath,
                                    cover: cubit.coverPath,
                                    name: cubit.changeUserNameController.text,
                                    bio: cubit.changeUserBioController.text,
                                    youtubeLink:
                                        cubit.changeYoutubeLinkController.text,
                                    facebookLink:
                                        cubit.changeFacebookLinkController.text,
                                    twitterLink:
                                        cubit.changeTwitterLinkController.text,
                                    instagramLink: cubit
                                        .changeInstagramLinkController.text,
                                  )
                                      .then((value) {
                                    customToast(
                                        title: 'Data Updated',
                                        color: AppColors.primaryColor1);

                                    cubit.getUser(context);
                                    cubit.getPosts().then((value) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeLayout()),
                                        (route) => false,
                                      );
                                      customToast(
                                          title: 'Data Updated',
                                          color: AppColors.primaryColor1);
                                    });
                                  });

                                  printMessage(
                                      cubit.changeUserNameController.text);
                                } else {
                                  customToast(
                                      title: 'Name is required',
                                      color: Colors.red);
                                }

                                // Navigator.pushNamed(context, 'edit_profile');
                              }),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  Widget _buildDropdownItem(Country country) => Container(
        padding: const EdgeInsets.all(10),
        width: 290,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              country.name,
              style: TextStyle(
                  color: AppColors.myGrey, fontFamily: AppStrings.appFont),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      );
}
