part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesSuccess(this.categories);
}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesFailure extends CategoriesState {
  final String errorMessage;

  CategoriesFailure(this.errorMessage);
}
