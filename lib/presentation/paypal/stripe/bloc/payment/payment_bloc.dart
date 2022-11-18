import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fanchat/presentation/paypal/stripe/bloc/payment/payment_events.dart';
import 'package:fanchat/presentation/paypal/stripe/bloc/payment/payment_states.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStart>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);
  }

  void _onPaymentStart(
    PaymentStart event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(
    PaymentCreateIntent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
          paymentMethodData:
              PaymentMethodData(billingDetails: event.billingDetails)),
    );
    // final paymentIntentResults =
    await _callPayEndpointMethodId(
            useStripeSdk: true,
            paymentMethodId: paymentMethod.id,
            currency: 'usd',
            items: event.items)
        .then((value) {
      // print('value length --------------------->$value');
      if (value['error'] != null) {
        emit(state.copyWith(status: PaymentStatus.failure));
      }
      if (value['clientSecret'] != null && value['requiredAction'] == null) {
        emit(state.copyWith(status: PaymentStatus.success));
      }
      if (value['clientSecret'] != null && value['requiredAction'] == true) {
        final String clientSecret = value['clientSecret'];
        add(PaymentConfirmIntent(clientSecret: clientSecret));
      }
    }).catchError((error) {
      // print('there is error hereeeeeeeeeeee------>${error.toString()}');
    });
  }

  void _onPaymentConfirmIntent(
    PaymentConfirmIntent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(event.clientSecret);
      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        Map<String, dynamic> results = await _callPayEndpointIntent(
          paymentIntentId: paymentIntent.id,
        );
        if (results['error'] != null) {
          emit(state.copyWith(status: PaymentStatus.failure));
        } else {
          emit(state.copyWith(status: PaymentStatus.success));
        }
      }
    } catch (e) {
      // print(e);
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointIntent({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(
        'https://us-central1-fanchat-7db9e.cloudfunctions.net/$paymentIntentId');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'paymentIntentId': paymentIntentId,
        }));
    return json.decode(response.body);
  }
////////////////////////////////////////////////

  Future _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    final url = Uri.parse(
        'https://us-central1-fanchat-7db9e.cloudfunctions.net/$paymentMethodId');
// print('start payment ----------------');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'useStripeSdk': useStripeSdk,
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          'items': items,
        }));
    http.Response redirectResponse =
        await http.get(Uri.parse(response.headers['location']!));
// print(Uint8List.fromList(redirectResponse.bodyBytes));
    return json.decode(json.encode(redirectResponse.body));
  }
}

// // print('statues-------------------------->${redirectResponse.statusCode}');
// // print('statues-------------------------->${(redirectResponse.body)}');
