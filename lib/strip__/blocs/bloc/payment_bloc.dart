// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
//
// part 'payment_event.dart';
// part 'payment_state.dart';
//
// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
//   PaymentBloc() : super(const PaymentState()) {
//     on<PaymentStart>(_onPaymentStart);
//     on<PaymentCreateIntent>(_onPaymentCreateIntent);
//     on<PaymentConfirmIntent>(_onPaymentConfirmInent);
//   }
//
//   void _onPaymentStart(PaymentStart event, Emitter<PaymentState> emit) {
//     emit(state.copyWith(status: PaymentStatus.initial));
//   }
//
//   void _onPaymentCreateIntent(
//     PaymentCreateIntent event,
//     Emitter<PaymentState> emit,
//   ) async {
//     emit(state.copyWith(status: PaymentStatus.loading));
//
//     final paymentMethod = await Stripe.instance.createPaymentMethod(
//       params: PaymentMethodParams.card(
//         paymentMethodData:
//             PaymentMethodData(billingDetails: event.billingDetails),
//       ),
//     );
//
//     ///
//
//     final paymentIntentResult = await _callPayEndPointMethodId(
//       useStripeSdk: true,
//       paymentMethodId: paymentMethod.id,
//       currency: 'usd',
//       items: event.items,
//     );
//
//     ///
//     if (paymentIntentResult['error'] != null) {
//       emit(state.copyWith(status: PaymentStatus.failure));
//     }
//
//     if (paymentIntentResult['clientSecret'] != null &&
//         paymentIntentResult['requiresAction'] == null) {
//       emit(state.copyWith(status: PaymentStatus.success));
//     }
//
//     if (paymentIntentResult['clientSecret'] != null &&
//         paymentIntentResult['requiresAction'] == true) {
//       final String clientSecret = paymentIntentResult['clientSecret'];
//       add(PaymentConfirmIntent(clientSecret: clientSecret));
//     }
//   }
//
//   void _onPaymentConfirmInent(
//     PaymentConfirmIntent event,
//     Emitter<PaymentState> emit,
//   ) async {
//     try {
//       final paymentIntent =
//           await Stripe.instance.handleNextAction(event.clientSecret);
//
//       ///
//       if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
//         ///
//         Map<String, dynamic> result = await _callPayEndPointIntentId(
//           paymentIntentId: paymentIntent.id,
//         );
//         if (result['error'] != null) {
//           emit(state.copyWith(status: PaymentStatus.failure));
//         } else {
//           emit(state.copyWith(status: PaymentStatus.success));
//         }
//
//         ///
//       }
//
//       ///
//     } catch (e) {
//       print(e.toString());
//       emit(state.copyWith(status: PaymentStatus.failure));
//     }
//   }
//
//   /// ========================================================
//   Future<Map<String, dynamic>> _callPayEndPointIntentId({
//     required String paymentIntentId,
//   }) async {
//     final url = Uri.parse(
//       'https://us-central1-fanchat-7db9e.cloudfunctions.net/StripePayEndpointIntentId',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(
//         {
//           'paymentIntentId': paymentIntentId,
//         },
//       ),
//     );
//     return json.decode(response.body);
//   }
//
//   /// ========================================================
//   Future<Map<String, dynamic>> _callPayEndPointMethodId({
//     required bool useStripeSdk,
//     required String paymentMethodId,
//     required String currency,
//     List<Map<String, dynamic>>? items,
//   }) async {
//     final url = Uri.parse(
//       'https://us-central1-fanchat-7db9e.cloudfunctions.net/StripePayEndpointMethodId',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(
//         {
//           'useStripeSdk': useStripeSdk,
//           'paymentMethodId': paymentMethodId,
//           'currency': currency,
//           'items': items,
//         },
//       ),
//     );
//     return json.decode(response.body);
//     // json.decode(response.body);
//   }
// }
