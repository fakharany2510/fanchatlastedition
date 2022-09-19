import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesScreen extends StatefulWidget {

  CountriesScreen({Key? key}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  var searchController=TextEditingController();

  var items;



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);


          return Scaffold(
            appBar: customAppbar('', context),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10
                ),
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                        color:AppColors.myGrey,
                        fontFamily: AppStrings.appFont,
                      ),
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      decoration: InputDecoration(
                        focusColor: AppColors.myGrey,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:AppColors.myGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:AppColors.myGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        prefixIcon: Icon(
                          Icons.search
                        ),
                      ),

                    ),
                    SizedBox(height: 10,),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          final text = cubit.countries[index];
                          return Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${cubit.countries[index]['image']}'),
                                opacity: .7
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(cubit.countries[index]['name'],style: TextStyle(
                                      color: AppColors.primaryColor1,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppStrings.appFont
                                  ),
                                  ),
                                )
                              ],
                            ),
                          );

                        },
                        separatorBuilder: (context,index){
                           return SizedBox(height: 10,);
                        },
                        itemCount: cubit.countries.length
                    )
                  ],
                ),
              ),
            ),
          );
      },
    );

  }
  void filterSearchResults(String query,context) {
   items= AppCubit.get(context).countries;
     final suggestions = AppCubit.get(context).countries.where((text){

       final itemTitle= text['name'];
       final input= query.toLowerCase();

      return itemTitle.contains(input);

     }).toList();

     setState(() {
         items=suggestions;
     });
  }


}
