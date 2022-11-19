import 'package:fanchat/presentation/paypal/stripe/bloc/blocs.dart';
import 'package:fanchat/presentation/paypal/stripe/bloc/payment/payment_events.dart';
import 'package:fanchat/presentation/paypal/stripe/bloc/payment/payment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CardFormScreen extends StatefulWidget {
  const CardFormScreen({super.key});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('payment'),
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            CardFormEditController cardController = CardFormEditController(
              initialDetails: state.cardFieldInputDetails,
            );

            if (state.status == PaymentStatus.initial) {
              return Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Opacity(
                        opacity: 1,
                        child: Image(
                          image: AssetImage(
                              'assets/images/public_chat_image.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Card Form',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        CardFormField(
                          controller: cardController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              (cardController.details.complete)
                                  ? context.read<PaymentBloc>().add(
                                        const PaymentCreateIntent(
                                            billingDetails: BillingDetails(
                                                name: 'Fanchat App',
                                                email: 'faharany00@gmail.com',
                                                phone: '01011755619'),
                                            items: [
                                              {'id': 0}
                                            ]),
                                      )
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'the form is not compelete')),
                                    );
                            },
                            child: const Text('Pay'))
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state.status == PaymentStatus.success) {
              return const Center(
                child: Text('Successed'),
              );
            }
            if (state.status == PaymentStatus.failure) {
              return const Center(
                child: Text('Failed'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
