import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data_source/remote/errors/failures.dart';
import '../../data/models/brand_model.dart';
import '../../data/repo/brands_repo.dart';

part 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit(this.brandsRepo) : super(BrandsLoading()) {
    getBrands();
  }

  BrandsRepo brandsRepo;

  Future<void> getBrands() async {
    try {
      final brands = await brandsRepo.getBrands();
      emit(BrandsSuccess(brands));
    } catch (e) {
      if (e is DioException) {
        emit(BrandsFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(BrandsFailure(e.toString()));
      }
    }
  }
}
