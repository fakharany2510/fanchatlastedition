import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/team_chat/team_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final ScrollController _childScrollController = ScrollController();
  final ScrollController _parentScrollController = ScrollController();
  String name = "";
  List<Map<String, dynamic>> data = [];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('countries').add(element);
    }
    // print('all data added');
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.primaryColor1,
              body: Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Opacity(
                        opacity: 1,
                        child: Image(
                          image: AssetImage(
                              'assets/images/public_chat_image.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SingleChildScrollView(
                    controller: _parentScrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
                          child: SizedBox(
                            height: 45,
                            child: Card(
                              elevation: 0,
                              child: TextField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search Your Favourite Team...'),
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        NotificationListener(
                          onNotification: (ScrollNotification notification) {
                            if (notification is ScrollUpdateNotification) {
                              if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                                debugPrint('Reached the bottom');
                                _parentScrollController.animateTo(
                                    _parentScrollController
                                        .position.maxScrollExtent,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              } else if (notification.metrics.pixels ==
                                  notification.metrics.minScrollExtent) {
                                debugPrint('Reached the top');
                                _parentScrollController.animateTo(
                                    _parentScrollController
                                        .position.minScrollExtent,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              }
                            }
                            return true;
                          },
                          child: AppCubit.get(context).countries.isNotEmpty
                              ? ListView.builder(
                                  controller: _childScrollController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      AppCubit.get(context).countries.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        AppCubit.get(context).countries[index]
                                            as Map<String, dynamic>;

                                    if (name.isEmpty) {
                                      return InkWell(
                                          onTap: () {
                                            AppCubit.get(context)
                                                .deleteCheeringPost(
                                                    countryName: data['name'])
                                                .then((value) {
                                              AppCubit.get(context).isLast =
                                                  true;
                                              AppCubit.get(context).isWaiting =
                                                  false;
                                              AppCubit.get(context)
                                                  .updateWaitingCheering(
                                                countryName: data['name'],
                                              );
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TeamChatScreen(
                                                            countryName:
                                                                data['name'],
                                                            countryImage:
                                                                data['image'],
                                                          )));
                                            });

                                            // AppCubit.get(context).deleteWaitingPost().then((value) {
                                            //
                                            // });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13, right: 13, bottom: 5),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .08,
                                              decoration: BoxDecoration(
                                                  color: AppColors.myGrey
                                                      .withOpacity(.1)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .01,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: ListTile(
                                                      title: Text(
                                                        data['name'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      leading: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .myWhite,
                                                                  width: 1)),
                                                          child:
                                                              CachedNetworkImage(
                                                            cacheManager:
                                                                AppCubit.get(
                                                                        context)
                                                                    .manager,
                                                            imageUrl:
                                                                "${data['image']}",
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            fit: BoxFit.cover,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .04,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .06,
                                                          )

                                                          // Image(
                                                          //   image: NetworkImage(data['image']),
                                                          //   fit: BoxFit.cover,
                                                          //   height:MediaQuery.of(context).size.height*.04,
                                                          //   width:MediaQuery.of(context).size.height*.06,
                                                          // ),
                                                          )),
                                                ),
                                              ),
                                            ),
                                          ));
                                    }
                                    if (data['name']
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(name.toLowerCase())) {
                                      return InkWell(
                                          onTap: () {
                                            // CashHelper.saveData(key: 'country',value:data['name'] ).then((value){
                                            //   //AppCubit.get(context).getTeamChat(data['name']);
                                            //
                                            // });
                                            AppCubit.get(context).isLast = true;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TeamChatScreen(
                                                          countryName:
                                                              data['name'],
                                                          countryImage:
                                                              data['image'],
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13, right: 13, bottom: 5),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .08,
                                              decoration: BoxDecoration(
                                                  color: AppColors.myGrey
                                                      .withOpacity(.3)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: ListTile(
                                                  title: Text(
                                                    data['name'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            AppStrings.appFont,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data['image']),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ));
                                    }
                                    return Container();
                                  })
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
