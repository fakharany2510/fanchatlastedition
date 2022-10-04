import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/team_chat/team_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  String name = "";
  List<Map<String, dynamic>> data = [

  ];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('countries').add(element);
    }
    print('all data added');
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(builder: (context,state){
      return Scaffold(
        backgroundColor: AppColors.primaryColor1,
          body: SingleChildScrollView(
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
            height: 45,
            child: Card(
              elevation: 0,
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search Your Favourite Team...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),

          ),
        ),
      StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('countries').orderBy('name').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                    as Map<String, dynamic>;

                    if (name.isEmpty) {
                      return InkWell(
                        onTap: (){

                          AppCubit.get(context).deleteCheeringPost().then((value) {
                            AppCubit.get(context).isLast=true;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                TeamChatScreen(countryName:data['name'],countryImage: data['image'],)
                            ));
                          });

                          // AppCubit.get(context).deleteWaitingPost().then((value) {
                          //
                          // });
                        },
                        child: ListTile(
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: AppStrings.appFont,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),

                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        ),
                      );
                    }
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return InkWell(
                        onTap: (){
                          // CashHelper.saveData(key: 'country',value:data['name'] ).then((value){
                          //   //AppCubit.get(context).getTeamChat(data['name']);
                          //
                          // });
                          AppCubit.get(context).isLast=true;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              TeamChatScreen(countryName:data['name'],countryImage: data['image'],)
                          ));
                        },
                        child: ListTile(
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppStrings.appFont,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        ),
                      );
                    }
                    return Container();
                  });
            },
          ),
      ],
      ),
      ),
      );
    }, listener: (context,state){});
  }
}