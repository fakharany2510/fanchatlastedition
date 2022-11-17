import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/payment_STRIPE/my_btn_register.dart';
import 'package:fanchat/payment_STRIPE/payment_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    StripeServices.init();
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.9),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor1,
      appBar: AppBar(
        title: Text("عملية الدفع لاستكمال الطلب"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor1,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            cardBgColor: AppColors.primaryColor1,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.mastercard,
                cardImage: Image.asset(
                  "assets/images/mastercard.png",
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: AppColors.primaryColor1,
                    textColor: AppColors.primaryColor1,
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: TextStyle(color: AppColors.primaryColor1),
                      labelStyle: TextStyle(color: AppColors.primaryColor1),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.primaryColor1),
                      labelStyle: TextStyle(color: AppColors.primaryColor1),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.primaryColor1),
                      labelStyle: TextStyle(color: AppColors.primaryColor1),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.primaryColor1),
                      labelStyle: TextStyle(color: AppColors.primaryColor1),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyBtnRegister(
                    title: 'send Order',
                    onTaped: () async {
                      if (formKey.currentState!.validate()) {
                        print('valid!');
                        print("#daaaaaaaa ${cardNumber}");
                        print(
                            "#daaaaaaaa ${int.parse(expiryDate.split('/')[0])}");
                        print(
                            "#daaaaaaaa ${int.parse(expiryDate.split('/')[1])}");
                        print("###### ${cardNumber}");
                        print("###### ${cardNumber.replaceAll(' ', '')}");
                        print("###### 4242424242424242");
                        /*final CreditCard testCard = CreditCard(
                              number: "4242424242424242",
                              expMonth: 12,
                              expYear: 25,
                              cvc: "123",
                            );*/
                        final CreditCard testCard = CreditCard(
                          number: cardNumber.replaceAll(' ', ''),
                          expMonth: int.parse(expiryDate.split('/')[0]),
                          expYear: int.parse(expiryDate.split('/')[1]),
                          cvc: cvvCode,
                        );

                        var response = await StripeServices.payNowHandler(
                            amount: '1000',
                            currency: 'EGP',
                            testCard: testCard);
                        print('response message ${response.message}');

                        //  PaymentMethod paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: testCard,),);
                        //   print("###### ${paymentMethod.id}");

                      } else {
                        print('invalid!');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
