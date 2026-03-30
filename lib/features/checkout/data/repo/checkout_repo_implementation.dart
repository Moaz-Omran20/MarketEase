import 'package:dartz/dartz.dart';
import '../../../../core/data_source/remote/errors/failures.dart';
import '../../../../core/services/stripe_service.dart';
import '../../../../core/shared_models/payment_models/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImplementation extends CheckoutRepo {
  StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure( e.toString()));
    }
  }
}
