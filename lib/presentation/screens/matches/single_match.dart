// import 'package:fanchat/business_logic/cubit/app_cubit.dart';
// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/presentation/widgets/shared_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../constants/app_strings.dart';
//
// class SingleMatch extends StatelessWidget {
//   const SingleMatch({super.key}) ;
//
//   @override
//   Widget build(BuildContext context) {
//   return BlocConsumer<AppCubit,AppState>(
//       listener: (context,state){
//
//       },
//       builder: (context,state){
//         return Scaffold(
//           backgroundColor: AppColors.myWhite,
//           appBar: customAppbar('Match Details',context),
//
//           body: Stack(
//             children: [
//               Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   child:const Opacity(
//                     opacity: 1,
//                     child:  Image(
//                       image: AssetImage('assets/images/imageback.jpg'
//                           ''),
//                       fit: BoxFit.cover,
//
//                     ),
//                   )
//               ),
//
//               SingleChildScrollView(
//                 child: Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         margin: const EdgeInsets.fromLTRB(0,5, 0, 10),
//                         child: Column(
//                           children: [
//                             Material(
//                                 color: Colors.grey[200],
//                                 elevation: 5,
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       width: 110,
//                                       height: 50,
//                                       child:Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           const SizedBox(height: 12,),
//                                           Text('Group 5',style: TextStyle(
//                                               color: AppColors.primaryColor1,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500,
//                                               fontFamily: AppStrings.appFont
//                                           ),
//                                             textAlign: TextAlign.center,
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       width: double.infinity,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 15,
//                                                     backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[0+1]),
//                                                   ),
//                                                   const  SizedBox(height: 5,),
//                                                   Text('USA',style: TextStyle(
//                                                       color: AppColors.primaryColor1,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w600,
//                                                       fontFamily: AppStrings.appFont
//                                                   ),),
//                                                   const  SizedBox(height: 5,),
//                                                   Text('Coach Name',
//                                                   style: TextStyle(
//                                                     overflow: TextOverflow.ellipsis,
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.w500
//                                                   ),
//                                                   ),
//                                                   const  SizedBox(height: 10,),
//                                                   Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Text('RONALDO'),
//                                                           SizedBox(width:10),
//                                                           Icon(Icons.sports_volleyball,color: Colors.green,)
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 5,),
//                                                       Row(
//                                                         children: [
//                                                           Text('Messi'),
//                                                           SizedBox(width:10),
//                                                           Icon(Icons.sports_volleyball,color: Colors.green,),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                               const SizedBox(width: 5,),
//                                               Container(
//                                                 height: 2,
//                                                 width: 8,
//                                                 color: AppColors.primaryColor1,
//                                               ),
//                                               const SizedBox(width: 5,),
//                                               Column(
//                                                 children: [
//                                                   Container(
//                                                     width: 70,
//                                                     height: 35,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(90),
//                                                         border: Border.all(
//                                                             color: AppColors.primaryColor1
//                                                         ),
//                                                         color: AppColors.primaryColor1
//                                                     ),
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                       children: [
//                                                         SizedBox(height: 5,),
//                                                         Text('Not started',style: TextStyle(
//                                                             color: AppColors.myWhite,
//                                                             fontSize: 13,
//                                                             fontWeight: FontWeight.w500,
//                                                             fontFamily: AppStrings.appFont
//                                                         ),
//                                                           textAlign: TextAlign.center,
//                                                         ),
//                                                         const SizedBox(height: 5,),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5,),
//                                                   Text('20:10',style: TextStyle(
//                                                       color: AppColors.primaryColor1,
//                                                       fontSize: 12,
//                                                       fontWeight: FontWeight.w500,
//                                                       fontFamily: AppStrings.appFont
//                                                   ),
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(width: 5,),
//                                               Container(
//                                                 height: 2,
//                                                 width: 8,
//                                                 color: AppColors.primaryColor1,
//                                               ),
//                                               const SizedBox(width: 5,),
//                                               Column(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 15,
//                                                     backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[0+3]),
//                                                   ),
//                                                   const  SizedBox(height: 5,),
//                                                   Text('Senegal',style: TextStyle(
//                                                       color: AppColors.primaryColor1,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w600,
//                                                       fontFamily: AppStrings.appFont
//                                                   ),),
//                                                   const  SizedBox(height: 5,),
//                                                   Text('Coach Name',
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight.w500
//                                                     ),
//                                                   ),
//                                                   const  SizedBox(height: 10,),
//                                                   Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Text('RONALDO'),
//                                                           SizedBox(width:10),
//                                                           Icon(Icons.sports_volleyball,color: Colors.green,)
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 5,),
//                                                       Row(
//                                                         children: [
//                                                           Text('Messi'),
//                                                           SizedBox(width:10),
//                                                           Icon(Icons.sports_volleyball,color: Colors.green,),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 20,),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                   ],
//                                 )
//                             ),
//                             const SizedBox(height: 10,),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Center(
//                                   child: Text('Match Statistics',style: TextStyle(
//                                       color: AppColors.primaryColor1,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w900,
//                                       fontFamily: AppStrings.appFont
//                                   ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5,),
//                             Container(
//                               height: 1050,
//                               child: ListView.separated(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemBuilder: (context,index){
//                                     return InkWell(
//                                       onTap: (){
//
//                                       },
//                                       child: Container(
//                                         margin: const EdgeInsets.fromLTRB(15, 5,15,5),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primaryColor1,
//                                           borderRadius: BorderRadius.circular(20),
//                                         ),
//                                         width: double.infinity,
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: const [
//                                              SizedBox(height: 10,),
//                                             Text('Man Of The Match',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 18,
//                                               fontFamily: AppStrings.appFont
//                                             ),
//                                             ),
//                                             SizedBox(height:10,),
//                                             CircleAvatar(
//                                               backgroundImage:  AssetImage('assets/images/ronaldo.jpg'),
//                                               radius: 50,
//                                             ),
//                                             SizedBox(height: 10,),
//                                             Text('Cristiano Ronaldo',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 18,
//                                                   fontFamily: AppStrings.appFont
//                                               ),
//                                             ),
//                                             SizedBox(height: 10,),
//
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   separatorBuilder: (context,index){
//                                     return  const SizedBox(height: 0,);
//                                   },
//                                   itemCount:1
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//   }
// }
