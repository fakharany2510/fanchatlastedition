import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_strings.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({super.key});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  List<String> dateMatchs = [
    '20 Nov',
    '21 Nov',
    '22 Nov',
    '23 Nov',
    '24 Nov',
    '25 Nov',
    '26 Nov',
    '27 Nov',
    '28 Nov',
    '29 Nov',
    '30 Nov',
    '1 Dec',
    '2 Dec',
    '3 Dec',
    '4 Dec',
    '6 Dec',
    '7 Dec',
    '8 Dec',
    '9 Dec',
    '10 Dec',
    '11 Dec',
    '12 Dec',
    '13 Dec',
    '14 Dec',
    '15 Dec',
    '16 Dec',
    '17 Dec',
    '18 Dec',
  ];

  List<String> dayMatchs = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  String? dateMatch = '22 Nov 2022';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
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
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Days List
                                Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/public_chat_image.jpeg'),
                                    fit: BoxFit.cover,
                                  )),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        .09,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                AppCubit.get(context).isDay =
                                                    List.generate(
                                                        28, (index) => false);
                                                AppCubit.get(context)
                                                        .isDay[index] =
                                                    !AppCubit.get(context)
                                                        .isDay[index];
                                              });

                                              AppCubit.get(context)
                                                  .getAllMatches(
                                                      doc: dateMatchs[index]);
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        dayMatchs[index],
                                                        style: TextStyle(
                                                            color: AppCubit.get(context)
                                                                            .isDay[
                                                                        index] ==
                                                                    true
                                                                ? AppColors
                                                                    .myWhite
                                                                : Colors
                                                                    .grey[600],
                                                            fontSize: 10,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        dateMatchs[index],
                                                        style: TextStyle(
                                                            color: AppCubit.get(context)
                                                                            .isDay[
                                                                        index] ==
                                                                    true
                                                                ? AppColors
                                                                    .myWhite
                                                                : Colors
                                                                    .grey[600],
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width: 1,
                                                    height: 25,
                                                    color: AppColors.myGrey,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 0,
                                          );
                                        },
                                        itemCount: dateMatchs.length),
                                  ),
                                ),

                                const SizedBox(
                                  height: 0,
                                ),

                                // Matches List
                                Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/public_chat_image.jpeg'),
                                    fit: BoxFit.cover,
                                  )),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: AppColors.primaryColor1,
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  AppCubit.get(context)
                                                      .allMatches[index]
                                                      .date!,
                                                  style: TextStyle(
                                                      color: AppColors.myWhite,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          AppStrings.appFont),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child:
                                                              CachedNetworkImage(
                                                            cacheManager:
                                                                AppCubit.get(
                                                                        context)
                                                                    .manager,
                                                            imageUrl: AppCubit
                                                                    .get(
                                                                        context)
                                                                .allMatches[
                                                                    index]
                                                                .firstImage!,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          AppCubit.get(context)
                                                              .allMatches[index]
                                                              .firstTeam!,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .myWhite,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  AppStrings
                                                                      .appFont),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .myWhite),
                                                              color: AppColors
                                                                  .primaryColor1),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                'Not Started',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .myWhite,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        AppStrings
                                                                            .appFont),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child:
                                                              CachedNetworkImage(
                                                            cacheManager:
                                                                AppCubit.get(
                                                                        context)
                                                                    .manager,
                                                            imageUrl: AppCubit
                                                                    .get(
                                                                        context)
                                                                .allMatches[
                                                                    index]
                                                                .secondImage!,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          AppCubit.get(context)
                                                              .allMatches[index]
                                                              .secondTeam!,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .myWhite,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  AppStrings
                                                                      .appFont),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 0,
                                        );
                                      },
                                      itemCount: AppCubit.get(context)
                                          .allMatches
                                          .length),
                                ),
                              ],
                            ))
                      ],
                    ),
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
