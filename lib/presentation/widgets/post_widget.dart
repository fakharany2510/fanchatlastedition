import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/data/modles/create_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buidPostItem(context,BrowisePostModel model,index)=>Card(
  elevation: 2,
  shadowColor: Colors.grey[150],
  child: Padding(
    padding: const EdgeInsets.only(bottom: 0,),
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
                  backgroundImage: NetworkImage('${model.image}'),
                  radius: 18,
                ),
                const SizedBox(width: 7,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('${model.name}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text('${model.dateTime}',
                  overflow: TextOverflow.ellipsis,
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
            padding: const EdgeInsets.only(bottom: 5,top: 5),
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
          (model.postImage!='')
          ?Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height*.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image:  DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ):SizedBox(height: 0,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 15),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  AppCubit.get(context).likePosts((AppCubit.get(context).postsId[index])).then((value) {
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*.3,
                  height: MediaQuery.of(context).size.height*.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${AppCubit.get(context).likes[index]}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(width: 3,),
                      Icon(Icons.favorite_border_outlined,size:22,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),

              ),
              SizedBox(width: MediaQuery.of(context).size.width*.1,),
              Container(
                color: Colors.grey,
                height: 25,
                width: 1,

              ),
              SizedBox(width: MediaQuery.of(context).size.width*.1,),
              InkWell(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width*.3,
                  height: MediaQuery.of(context).size.height*.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('300',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(width: 3,),
                      Icon(Icons.comment,size:22,
                        color: Colors.grey,
                      )

                    ],
                  ),
                ),

              ),
            ],
          )
        ],
      ),
    ),
  ),
);