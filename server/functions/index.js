const functions = require("firebase-functions");
const stripe = require("stripe")(functions.config().stripe.testkey);

const calculateOrderAmount = (items) => {
    price = [];
    catalog = [
        { id: "0", price: 5 },
        { id: "1", price: 10 },
        { id: "2", price: 20 },
        { id: "3", price: 30 },
        { id: "4", price: 40 },
    ];
    items.forEach((item) => {
    price = catalog.find(x => x.id).price;
    price.push(price);
    });
    return parseInt(price.reduce((a, b) => a + b) * 100);
  }


const generateResponse = function (intent) {
    switch (intent.status) {
        case "requires_action":
        return {
        clientSecret: intent.client_secret,
        requiresAction: true,
        status: intent.status,
        };
        case "requires_payment_method":
          return {
          error: "Your card was denied, please provide a new payment method",
          };
        case "succeeded":
          console.log('PaymentIntent succeeded!');
          return { clientSecret: intent.client_secret, status: intent.status };
    }
    return { error: "Failed" };
}
exports.StripePayEndpointMethodId =
functions.https.onRequest(async (req, res) => {
  const { paymentMethodId, items, currency,useStripeSdk } = req.body;

  const orderAmount = calculateOrderAmount(items);
  try {
    if(paymentMethodId){
    const params = {
    amount: orderAmount,
    confirm: true,
    confirmation_method: "manual",
    currency: currency,
    payment_method: paymentMethodId,
    use_stripe_sdk: useStripeSdk,
        }
    const intent = await stripe.paymentIntents.create(params);
    console.log(`Intent: ${intent}`);
    return res.send(generateResponse(intent));
    }
    return res.sendStatus(400)
  } catch (e) {
    return res.sendStatus({ error: e.message });
  }
});

exports.StripePayEndpointInternetId =
functions.https.onRequest(async (req, res) => {
  const { paymentMethodId } = req.body;
  try {
  if(paymentInternetId){
    const intent = awa3it stripe.paymentIntents.confirm(paymentInternetId);
    return res.send(generateResponse(intent));
    }
    return res.sendStatus(400);
  } catch (e) {
    return res.send({ error: e.message });
  }

});