// import 'package:fanchat/business_logic/cubit/app_cubit.dart';
// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/constants/app_strings.dart';
// import 'package:fanchat/presentation/widgets/shared_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AddAdvertuser extends StatelessWidget {
//    AddAdvertuser({super.key}) ;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppState>(
//         listener: (context,state){
//             if(state is UploadAdvertisingImageSuccessState){
//               customToast(title: 'Advertisng Upload', color: AppColors.primaryColor1);
//             }
//         },
//       builder: (context,state){
//           return Scaffold(
//             appBar: AppBar(
//                 toolbarHeight: 0,
//             ),
//             body: SingleChildScrollView(
//               child: Container(
//                 child:  Column(
//                   children:  [
//                     // SizedBox(height: MediaQuery.of(context).size.height*.07,),
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       child: TextFormField(
//                         style: TextStyle(
//                           color:AppColors.primaryColor1,
//                           fontFamily: AppStrings.appFont,
//                         ),
//                         keyboardType: TextInputType.text,
//                         controller: AppCubit.get(context).advertisingLink,
//                         onChanged: (value){
//                         },
//                         decoration: InputDecoration(
//                           focusColor: AppColors.myGrey,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color:AppColors.myGrey),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15)
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color:AppColors.myGrey),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           hintText: 'Enter Advertising Link',
//                           hintStyle: TextStyle(
//                             color: AppColors.myGrey,
//                             fontFamily: AppStrings.appFont,
//                           ),
//                           prefixIcon: Icon(
//                             Icons.link
//                           ),
//                         ),
//                         validator: (value){
//                           if(value!.isEmpty){
//                             return'please enter advertising link';
//                           }
//                         },
//                       ),
//                     )   ,
//                     SizedBox(height: MediaQuery.of(context).size.height*.01,),
//                     Container(
//                        margin: const EdgeInsets.all(
//                          10
//                        ),
//                        height: 350,
//                        width: double.infinity,
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: AppColors.primaryColor1
//                          ),
//                          borderRadius: BorderRadius.circular(12),
//                          image: AppCubit.get(context).uploadAdvertisingImage != null?  DecorationImage(
//                            fit: BoxFit.fill,
//                            image:
//                            FileImage(AppCubit.get(context).uploadAdvertisingImage!)
//
//                          ): DecorationImage(
//                              fit: BoxFit.fill,
//                              image:
//                              NetworkImage('https://img.freepik.com/premium-photo/vintage-televisions-turned-floor_103577-5495.jpg?w=900')
//
//                          )
//                        ),
//                      ),
//                     SizedBox(height: MediaQuery.of(context).size.height*.025,),
//                     AppCubit.get(context).uploadAdvertisingImage == null?
//                     Container(
//                         margin: EdgeInsets.all(
//                           15
//                         ),
//                         child: defaultButton(
//                              width: 250,
//                              height: 50,
//                              buttonColor: AppColors.primaryColor1,
//                              textColor: Colors.white,
//                              buttonText: 'Add Advertising',
//                              function: (){
//                                     AppCubit.get(context).getAdvertisingImage();
//                              }
//                          ),
//                       ): state is UploadAdvertisingImageLoadingState?
//                     CircularProgressIndicator(
//                       color: AppColors.primaryColor1,
//                     ):
//                     Container(
//                       margin: EdgeInsets.all(
//                           15
//                       ),
//                       child: defaultButton(
//                           width: 250,
//                           height: 50,
//                           buttonColor: AppColors.primaryColor1,
//                           textColor: Colors.white,
//                           buttonText: 'Upload Advertising',
//                           function: (){
//                             AppCubit.get(context).uploadAdvertising(advertisingLink: AppCubit.get(context).advertisingLink.text);
//                           }
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//       },
//     );
//   }
// }
