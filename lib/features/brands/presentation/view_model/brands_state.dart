part of 'brands_cubit.dart';

@immutable
sealed class BrandsState {}

final class BrandsSuccess extends BrandsState {
  final List<BrandModel> brands;

  BrandsSuccess(this.brands);
}
final class BrandsLoading extends BrandsState {}
final class BrandsFailure extends BrandsState {
 final String errorMessage ;

  BrandsFailure(this.errorMessage);
}
