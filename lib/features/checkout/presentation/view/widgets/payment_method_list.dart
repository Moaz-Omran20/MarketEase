import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_ease/core/theme/light_colors.dart';
import '../../../../../core/shared_models/payment_models/payment_method_model.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethodModel paymentMethodModel;
  final bool isActive ;


  const PaymentMethodItem({super.key, required this.paymentMethodModel,required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 62,
        width: MediaQuery.of(context).size.width * .2,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color:  isActive
                ? LightColors.primaryColor :Colors.white,width: 2,),
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(paymentMethodModel.image, height: 24,fit: BoxFit.scaleDown,),
        ),
      ),
    );
  }
}
