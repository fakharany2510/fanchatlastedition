import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppbar('Profile'),
      backgroundColor: AppColors.myWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //profile
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh3OAATrejFnDfO1YeDhvHNCgsepjMSXV-wA&usqp=CAU'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 57,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png'),
                        radius: 55,
                      ),
                    ),
                  ],
                ),
              ),

            ),
            SizedBox(height:5,),
            //name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ahmed Elfakharany',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(width: 5,),
                Icon(Icons.check_circle,color: Colors.blue,size:15,),
              ],
            ),
            SizedBox(height:15,),
            defaultButton(
                buttonText: 'Edit Profile',
                buttonColor: AppColors.primaryColor,
                height: size.height*.06,
                width: size.width*.4,
                function: (){
                  Navigator.pushNamed(context, 'edit_profile');
                }
            ),
          ],
        ),
      ),
    );
  }
}
