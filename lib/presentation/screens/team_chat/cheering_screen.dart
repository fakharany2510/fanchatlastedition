// ignore_for_file: must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CheeringScreen extends StatefulWidget {
  CheeringScreen(
      {super.key, required this.countryName, required this.countryImage});
  String? countryName;
  String? countryImage;

  @override
  State<CheeringScreen> createState() => _CheeringScreenState();
}

class _CheeringScreenState extends State<CheeringScreen> {
  var cheeringController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool cheeringControllerChanges = false;

  @override
  void initState() {
    AppCubit.get(context).getWaitingCheering(countryName: widget.countryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CreateCheeringSuccessState) {
          AppCubit.get(context)
              .getCheeringPost(countryName: widget.countryName)
              .then((value) {
            // AppCubit.get(context).getWaitingPost();
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            // const HomeLayout()), (Route<dynamic> route) => false);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
            //   return TeamChatScreen(countryName: widget.countryName!, countryImage: widget.countryImage!);
            // }));
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: customAppbar('Profile', context),
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
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/uninform_cheer_icon.svg',
                          fit: BoxFit.contain,
                          height: 70,
                          width: 70,
                          color: AppColors.primaryColor1,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send a uniform cheer to all your team fans \n and share the fun with every one',
                            style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppStrings.appFont),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          // height:MediaQuery.of(context).size.height*.07,
                          child: Form(
                            key: formKey,
                            onChanged: () {
                              setState(() {
                                cheeringControllerChanges = true;
                              });
                            },
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(70),
                              ],
                              style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 17),
                              maxLines: 3,
                              keyboardType: TextInputType.text,
                              controller: cheeringController,
                              decoration: InputDecoration(
                                focusColor: AppColors.myGrey,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                // hintText: '$labelText',
                                // hintStyle: TextStyle(
                                //   color: AppColors.myGrey,
                                //   fontFamily: AppStrings.appFont,
                                // ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Write uniform cheering';
                                }
                                return null;
                              },
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      state is CreateCheeringLoadingState
                          ? CircularProgressIndicator(
                              color: AppColors.primaryColor1,
                            )
                          : (cheeringControllerChanges == true) &&
                                  (cheeringController.text != '')
                              ? defaultButton(
                                  buttonText: 'Post',
                                  textColor: AppColors.myWhite,
                                  buttonColor: const Color(0Xffd32330),
                                  width: MediaQuery.of(context).size.width * .6,
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  function: () {
                                    AppCubit.get(context).count = 17;
                                    if (AppCubit.get(context).isWaiting ==
                                        false) {
                                      AppCubit.get(context).createCheeringPost(
                                        time: DateFormat.Hm()
                                            .format(DateTime.now()),
                                        timeSpam: DateTime.now().toString(),
                                        text: cheeringController.text,
                                        countryName: widget.countryName,
                                      );
                                      AppCubit.get(context).isWaiting = true;
                                      // print('here');
                                      AppCubit.get(context)
                                          .updateWaitingCheering(
                                              countryName: widget.countryName);
                                    } else {
                                      customToast(
                                          title:
                                              'Please, Wait few seconds and try again',
                                          color: AppColors.primaryColor1);
                                      // Navigator.pop(context);

                                    }

                                    // AppCubit.get(context).getCheeringPost();
                                    // AppCubit.get(context).isLast=false;
                                  })
                              : defaultButton(
                                  width: MediaQuery.of(context).size.width * .8,
                                  height:
                                      MediaQuery.of(context).size.height * .07,
                                  buttonColor: AppColors.myGrey,
                                  textColor: AppColors.primaryColor1,
                                  buttonText: 'Send',
                                  function: () {})
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
