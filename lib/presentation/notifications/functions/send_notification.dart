// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:http/http.dart' as http;

List<String> userToken = [];

Future<void> callFcmApiSendPushNotifications(
    {required String title,
    required String imageUrl,
    required String description,
    context}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  FirebaseFirestore.instance.collection('tokens').get().then((value) {
    value.docs.forEach((element) async {
      userToken.add(element.toString());
      final data = {
        "to": element.toString(),
        "notification": {
          "title": title,
          "body": description,
          "image": imageUrl,
        },
        "data": {
          "type": '0rder',
          "id": "28",
          "click_action": 'FLUTTER_NOTIFICATION_CLICK',
          'title': title,
          'imageurl': imageUrl,
          'description': description,
        },
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
            'key=AAAAIqG6C9s:APA91bHMARfKha7noUEJOzAreVnEVX9kgkH8_TeV2sPiYqERN2IedimCpRNDjO7N9BMiHYYNEu3GolVunt14JtX7LI3nYv2TZ9me2vDtbeOpbCiVA4GXUuK5M22cZVRVV1ad9GQGF0ef', // 'key=YOUR_SERVER_KEY'
      };

      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        // print('Push Notification Succeded');
        AppCubit.get(context).getPosts();
      } else {
        // print('Push Notification Error');
      }
    });
  });
}
