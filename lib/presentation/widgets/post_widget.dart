import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buidPostItem(context)=>Padding(
  padding: const EdgeInsets.only(bottom: 5,),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png',),
                radius: 18,
              ),
              const SizedBox(width: 7,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Ahmed Elfakharany',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text('25/12',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey
              ),
              ),
            ],
          ),
        ),
        SizedBox(height:10),
        // if(model.postImage != '')
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: const DecorationImage(
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHTMtDJNrLN9o1nU2mdfTJVfjrart5NOhNeg&usqp=CAU'),
                    fit: BoxFit.fill
                )
            ),
          ),
        SizedBox(height:7),
        Padding(
          padding: const EdgeInsets.only(top:7,right: 0),
          child: GestureDetector(
            onTap: (){},
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width*.2,
                height:MediaQuery.of(context).size.height*.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.favorite_border,size: 20,color: Colors.red),
                    SizedBox(width: 2,),
                    Text('30',style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    ),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);