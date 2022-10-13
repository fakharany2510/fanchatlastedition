// import 'package:fanchat/business_logic/cubit/app_cubit.dart';
// import 'package:fanchat/presentation/screens/private_chat/messages_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../constants/app_colors.dart';
// import '../../constants/app_strings.dart';
// import '../../data/modles/user_model.dart';
//
// class ChatWediget extends StatelessWidget {
//   UserModel model;
//   ChatWediget( this.model);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppState>(
//         builder: (context , state){
//           return InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                   ChatDetails(
//                       userModel: model)));
//               print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhb${model.uId}');
//             },
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundImage: NetworkImage('${model.image}'),
//                     ),
//                     const SizedBox(width: 10,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         Text('${model.username!}',style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.myWhite,
//                             fontFamily: AppStrings.appFont
//                         ),),
//                         // const SizedBox(height: 10,),
//                         // Text('How are you...?!',style: TextStyle(
//                         //     fontSize: 14,
//                         //     fontWeight: FontWeight.w600,
//                         //     color: AppColors.navBarActiveIcon,
//                         //     fontFamily: AppStrings.appFont
//                         // ),
//                         // ),
//                       ],
//                     ),
//                     // const Spacer(),
//                     // Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.center,
//                     //   children: [
//                     //     Text('04:00',style: TextStyle(
//                     //         fontSize: 14,
//                     //         fontWeight: FontWeight.bold,
//                     //         color: AppColors.navBarActiveIcon,
//                     //         fontFamily: AppStrings.appFont
//                     //     ),),
//                     //     const SizedBox(height: 10,),
//                     //     CircleAvatar(
//                     //       radius: 13,
//                     //       backgroundColor: AppColors.navBarActiveIcon,
//                     //       child: Text('8',style: TextStyle(
//                     //           fontSize: 13,
//                     //           fontWeight: FontWeight.bold,
//                     //           color: AppColors.myWhite,
//                     //           fontFamily: AppStrings.appFont
//                     //       ),),
//                     //     ),
//                     //   ],
//                     // ),
//                     // const SizedBox(width: 20,)
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         listener: (context , state){});
//   }
// }
