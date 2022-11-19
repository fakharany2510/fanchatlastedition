import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/business_logic/advertising_cubit/advertising_state.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddAdvertisingImage extends StatefulWidget {
  const AddAdvertisingImage({super.key});

  @override
  State<AddAdvertisingImage> createState() => _AddAdvertisingImageState();
}

class _AddAdvertisingImageState extends State<AddAdvertisingImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AdvertisingCubit, AdvertisingState>(
      listener: (context, state) {
        if (state is AdvertisingCreatePostSuccessState) {
          AppCubit.get(context).currentIndex = 5;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayout()),
              (route) => false);
          //Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor1,
            title: Text('Add Image',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.myWhite,
                    fontFamily: AppStrings.appFont)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                setState(() {
                  // print('${AdvertisingCubit.get(context).AdvertisingPostImage}');
                  Navigator.pop(context);
                });
              },
            ),
            actions: [
              state is AdvertisingUploadImagePostLoadingState ||
                      state is BrowiseGetPostsLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultButton(
                          textColor: AppColors.primaryColor1,
                          width: size.width * .2,
                          height: size.height * .05,
                          raduis: 10,
                          function: () {
                            if (AdvertisingCubit.get(context)
                                    .AdvertisingPostImage ==
                                null) {
                              // print('no image chossen');
                            } else {
                              AdvertisingCubit.get(context)
                                  .uploadAdvertisingPostImage(
                                dateTime:
                                    DateFormat.yMMMd().format(DateTime.now()),
                                time: DateFormat.Hm().format(DateTime.now()),
                                timeSpam: DateTime.now().toString(),
                                text: "",
                                advertisingLink: AdvertisingCubit.get(context)
                                    .advertingImageLink
                                    .text,
                              );
                            }
                            // print(DateFormat.Hms().format(DateTime.now()));
                          },
                          buttonText: 'add',
                          buttonColor: AppColors.myWhite),
                    )
            ],
          ),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Opacity(
                    opacity: 1,
                    child: Image(
                      image: AssetImage('assets/images/public_chat_image.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                        color: AppColors.myWhite,
                        fontFamily: AppStrings.appFont,
                      ),
                      keyboardType: TextInputType.text,
                      controller:
                          AdvertisingCubit.get(context).advertingImageLink,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        focusColor: AppColors.myGrey,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.myGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.myGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter Advertising Link',
                        hintStyle: TextStyle(
                          color: AppColors.myGrey,
                          fontFamily: AppStrings.appFont,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter advertising link';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (AdvertisingCubit.get(context).AdvertisingPostImage != null)
                        ? Expanded(
                            child: SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Image(
                                  image: FileImage(AdvertisingCubit.get(context)
                                      .AdvertisingPostImage!),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                'No Photo Selected Yet',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont,
                                ),
                              ),
                            ),
                          ),
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
