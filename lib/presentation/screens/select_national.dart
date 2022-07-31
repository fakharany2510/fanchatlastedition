import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectNational extends StatefulWidget {
  SelectNational({Key? key}) : super(key: key);

  @override
  State<SelectNational> createState() => _SelectNationalState();
}

class _SelectNationalState extends State<SelectNational> {
  List<bool> checkValues= List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=AppCubit.get(context);

          return Scaffold(
                backgroundColor: AppColors.myWhite,
                appBar: AppBar(
                  backgroundColor: AppColors.myWhite,
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: AppColors.primaryColor1
                  ),
                  titleSpacing: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor:AppColors.myWhite
                  ),
                  title: Text('Select Favorite Team',style: TextStyle(
                    color: AppColors.primaryColor1,
                    fontSize: 19,
                    fontWeight: FontWeight.w500
                  ),),
                ),
                body:SizedBox(
                  height: 800,
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1/1.05,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(cubit.nationalTitles.length, (index) =>
                          Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20)

                        ),
                        padding:const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Checkbox(
                                activeColor: AppColors.primaryColor1,
                                checkColor: AppColors.myWhite,
                                  side: const BorderSide(color: Colors.red,width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  value: checkValues[index],
                                  onChanged: (v){
                                    setState(() {
                                      checkValues[index]=v!;
                                    });
                                  }
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(cubit.groupsImages[index]),
                            ),
                            const SizedBox(height: 10,),
                            Text(cubit.nationalTitles[index],style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontSize: 19,
                                fontWeight: FontWeight.w500
                            ),),
                          ],
                        ),
                      )
                      ),
                  ),
                )

            );
        },
    );
  }
}
