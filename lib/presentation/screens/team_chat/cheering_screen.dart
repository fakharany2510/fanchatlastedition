import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/team_chat/team_chat_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheeringScreen extends StatelessWidget {
  CheeringScreen({Key? key,required this.countryName,required this.countryImage}) : super(key: key);
  String ?countryName;
  String ?countryImage;

  var cheeringController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){
           if(state is CreateCheeringSuccessState){
             AppCubit.get(context).getCheeringPost().then((value) {
               Navigator.push(context, MaterialPageRoute(builder: (_){
                 return TeamChatScreen(countryName: countryName!, countryImage: countryImage!);
               }));
             });
           }
        },


        builder: (context,state){
            return Scaffold(
              appBar: customAppbar('Profile',context),

              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      SizedBox(height: MediaQuery.of(context).size.height*.15,),
                      const Image(
                        height: 90,
                        width: 90,
                        image: AssetImage('assets/images/cheers.png'),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Write uniform cheering',
                            style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppStrings.appFont
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height:  MediaQuery.of(context).size.height*.05,),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20
                        ),
                        // height:MediaQuery.of(context).size.height*.07,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(70),
                          ],
                          style: TextStyle(
                            color:AppColors.primaryColor1,
                            fontFamily: AppStrings.appFont,
                            fontSize: 17
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: cheeringController,
                          decoration: InputDecoration(

                            focusColor: AppColors.myGrey,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:AppColors.primaryColor1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:AppColors.primaryColor1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // hintText: '$labelText',
                            // hintStyle: TextStyle(
                            //   color: AppColors.myGrey,
                            //   fontFamily: AppStrings.appFont,
                            // ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Write uniform cheering';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.05,),
                      state is CreateCheeringLoadingState?
                      CircularProgressIndicator(
                        color: AppColors.primaryColor1,
                      ):
                      defaultButton(
                          width: MediaQuery.of(context).size.width*.8,
                          height: MediaQuery.of(context).size.height*.07,
                          buttonColor: AppColors.primaryColor1,
                          textColor: AppColors.myWhite,
                          buttonText: 'Post',
                          function: (){
                            AppCubit.get(context).count=17;
                            AppCubit.get(context).createCheeringPost(
                                  time: DateFormat.Hm().format(DateTime.now()),
                                  timeSpam: DateTime.now().toString(),
                                  text: cheeringController.text
                              );
                            // AppCubit.get(context).getCheeringPost();
                            // AppCubit.get(context).isLast=false;

                          }
                      )
                    ],
                  ),
                ),
              ),

            );
        },
    );
  }
}
