import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> callFcmApiSendPushNotificationsChat({
  required String title,
  required String imageUrl,
  required String description,
  required String token,
}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to": token,
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
  } else {
    // print('Push Notification Error');
  }
}
