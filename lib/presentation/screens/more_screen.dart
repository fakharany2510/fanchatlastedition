import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: AppColors.myWhite,
      body:Padding(
        padding:const  EdgeInsets.all(10),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png',),
              radius: 60,
            ),
            const SizedBox(height: 10,),
            const Text('Ahmed Elfkharany',style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                height: size.height,
                child: ListView(
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        width: size.width,
                        height: size.height*.06,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_pin,color: AppColors.primaryColor,size: 35,),
                            const SizedBox(width: 5,),
                            const Text('Profile',style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor,size: 20,),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, 'profile');
                      },
                    ),
                    const SizedBox(height:10),

                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
