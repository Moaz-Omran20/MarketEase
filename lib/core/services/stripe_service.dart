import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../data_source/remote/api_service.dart';
import '../shared_models/payment_models/ephemeral_key_model.dart';
import '../shared_models/payment_models/payment_intent_input_model.dart';
import '../shared_models/payment_models/payment_intent_model.dart';
import '../utils/api_keys.dart';

class StripeService {
  ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.paymentPost(
      body: paymentIntentInputModel.toJson(),
      url: "https://api.stripe.com/v1/payment_intents",
      token: ApiKeys.secretKey,
    );
    PaymentIntentModel paymentIntentModel = PaymentIntentModel.fromJson(
      response.data,
    );
    return paymentIntentModel;
  }

  Future<void> initPaymentSheet(String paymentIntentClientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "Moaz Omran",
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    var response = await apiService.paymentPost(
      body: {'customer': customerId},
      url: "https://api.stripe.com/v1/ephemeral_keys",
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Stripe-Version': '2025-12-15.clover',
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
      },
    );
    EphemeralKeyModel ephemeralKeyModel = EphemeralKeyModel.fromJson(
      response.data,
    );
    return ephemeralKeyModel;
  }
}
