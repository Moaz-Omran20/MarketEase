import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/data_source/remote/errors/failures.dart';
import '../../data/models/category_model.dart';
import '../../data/repo/category_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesLoading()) {
    getCategories();
  }

  CategoryRepo categoriesRepo;

  Future<void> getCategories() async {
    try {
      List<CategoryModel> categories = await categoriesRepo.getCategories();
      emit(CategoriesSuccess(categories));
    } catch (e) {
      if (e is DioException) {
        emit(CategoriesFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(CategoriesFailure(e.toString()));
      }
    }
  }
}
