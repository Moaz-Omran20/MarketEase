import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_models/payment_models/payment_intent_input_model.dart';
import '../../data/repo/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());

    var response = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    response.fold(
      (l) => emit(PaymentFailure(errorMessage: l.errorMessage)),
      (r) => emit(PaymentSuccess()),
    );
  }
}
