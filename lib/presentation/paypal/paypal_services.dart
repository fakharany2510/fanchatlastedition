// import 'package:http/http.dart' as http;
// import 'package:http_auth/http_auth.dart';
// import 'dart:convert' as convert;
// class PaypalServices {
//   // String domain = "https://api.paypal.com";
//   String domain = "https://api.sandbox.paypal.com";
//   String clientId = 'AXnkr1scHP80Xb0VBG94PFrmfTPR-LJhhFq7v4i9qgECwOBtJv3sHHm8zU7Xmrkw5m-Mew7hU8u7EkDn';
//   String secret = 'EI5W_uoWuY3uCBFAWzw0ofQb2N2zc6ZlI6FK9i7S669wi-_YIUfnumjBQC06rNMuu3tbOeuf_Ll1NTCk';
//
//
//   Future<String> getAccessToken() async {
//     try {
//       var client = BasicAuthClient(clientId, secret);
//       var response = await client.post(
//           Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
//       if (response.statusCode == 200) {
//         final body = convert.jsonDecode(response.body);
//         return body["access_token"];
//       }
//       return "0";
//     }
//     catch (e) {
//       rethrow;
//     }
//   }
//   Future<Map<String, String>> createPaypalPayment(transactions,
//       accessToken) async {
//     try {
//       var response = await http.post(Uri.parse('$domain/v1/payments/payment'),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": "Bearer" + accessToken
//           });
//       final body = convert.jsonDecode(response.body);
//       if (response.statusCode == 201) {
//         if (body["links"] != null && body["links"].length > 0) {
//           List links = body["links"];
//           String executeUrl = "";
//           String approvalUrl = "";
//           final item = links.firstWhere((o) => o["rel"] == "approval_url",
//               orElse: () => null);
//           if (item != null) {
//             approvalUrl = item["href"];}
//           final item1 = links.firstWhere((o) => o["rel"] == "execute",
//               orElse: () => null);
//           if (item1 != null) {
//             executeUrl = item1["href"];}
//           return {"excuteUrl": executeUrl, "approvalUrl": approvalUrl};}
//         throw Exception("0");
//       }
//       else {
//         throw Exception(body['message']);
//       }
//     }
//     catch (e) {
//       rethrow;
//     }
//   }
//
//
//   Future<String> executePayPal(url, payerId, accessToken) async {
//     try {
//       var response = await http.post(url,
//           body: convert.jsonEncode({"payer_id": payerId}),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": "Bearer" + accessToken
//           });
//       final body = convert.jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return body["id"];
//       }
//       return "0";
//     }
//     catch (e) {
//       rethrow;
//     }
//   }
// }