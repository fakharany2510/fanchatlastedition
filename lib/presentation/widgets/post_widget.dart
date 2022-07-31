import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/modles/create_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buidPostItem(context,BrowisePostModel model)=>Padding(
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
               CircleAvatar(
                backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                radius: 18,
              ),
              const SizedBox(width: 7,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                          style: const TextStyle(
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
              const Spacer(),
              Text('${model.dateTime}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey
              ),
              ),
            ],
          ),
        ),
        const SizedBox(height:5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('${model.text}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              )),
        ),
        const SizedBox(height:3),
        // if(model.postImage != '')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image:  DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
        const SizedBox(height:7),
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