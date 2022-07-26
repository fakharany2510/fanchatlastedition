import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buidPostItem(context)=>Padding(
  padding: const EdgeInsets.only(bottom: 5,),
  child: Card(
    margin:EdgeInsets.symmetric(horizontal: 10) ,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png',),
                radius: 30,
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Ahmed Elfakharany',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: Colors.blue,size:15,)
                      ],
                    ),
                    Text('25/10',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('Hellow World Cup',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              )),

          // if(model.postImage != '')
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: const DecorationImage(
                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.05,
            width: MediaQuery.of(context).size.width*.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('30',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(width: 5,),
                Icon(Icons.favorite,size: 30,color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);