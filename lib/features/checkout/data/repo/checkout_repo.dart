import 'package:dartz/dartz.dart';

import '../../../../core/data_source/remote/errors/failures.dart';
import '../../../../core/shared_models/payment_models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
