import 'dart:core';
import 'package:fanchat/presentation/paypal/paypal_services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  const PaypalPayment({required this.onFinish});

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  PaypalServices services=PaypalServices();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      try{
        accessToken=await services.getAccessToken();
        final transactions=getOrderParams();
        final res= await services.createPaypalPayment(transactions, accessToken);
        if(res!=null){
          checkoutUrl=res["approvalUrl"];
          executeUrl=res["excuteUrl"];
        }
      }
      catch(e){
        print('exception:'+e.toString());
      }
    });
  }
  Map<dynamic,dynamic> defaultCurrency={
    "symbol":"usd",
    "decimalDigints":2,
    "symbolBeforeTheNumber":true,
    "currency":"USD"
  };
  String itemName="fanchat app premium";
  String itemPrice="1.99";
   String returnURL="return.example,com";
   String cancelURL="cancle.example,com";

  Map<String , dynamic> getOrderParams(){
    Map<String,dynamic> temp={
    "intent": "sale",
    "payer": {
    "payment_method": "paypal"
    },

    "redirect_urls": {
    "return_url": returnURL,
    "cancel_url": cancelURL
    },
    "transactions": [{
    "item_list": {
    "items": [{
    "name": itemName,
    "sku": "item",
    "price": itemPrice,
    "currency": defaultCurrency["currency"],
    "quantity": 1
    }]
    },
    "amount": {
    "currency": defaultCurrency["currency"],
    "total": itemPrice
    },
    "description": "This is the payment for fanchat app."
    }]
    };
    return temp;
  }
  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);
    if(checkoutUrl!=null){
      return Scaffold(
        appBar: AppBar(
         leading: GestureDetector(
           child: Icon(Icons.arrow_back_ios),
           onTap: (){
             Navigator.pop(context);
           },
         ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate:(NavigationRequest request){
            if(request.url.contains(returnURL)){
              final uri = Uri.parse(request.url);
              final payerID=uri.queryParameters['PayerID'];
              if(payerID!=null){
                services.executePayPal(
                    executeUrl,
                    payerID,
                    accessToken).then((id){
                      widget.onFinish(id);
                      Navigator.pop(context);
                }).catchError((error){
                  print('error here ${error.toString()}');
                });
              }else{
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if(request.url.contains(cancelURL)){
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    }
    else{
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
