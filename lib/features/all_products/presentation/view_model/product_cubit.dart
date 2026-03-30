import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_ease/core/data_source/remote/errors/failures.dart';
import 'package:market_ease/core/shared_models/filter_model.dart';
import 'package:market_ease/features/all_products/data/repo/product_repo.dart';
import 'package:market_ease/features/all_products/presentation/view_model/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;

  ProductCubit(this.productRepo,FilterModel filteredProduct) : super(ProductLoading()){
    getProductsByBrand(filteredProduct);
  }

  Future<void> getProductsByBrand(FilterModel  filteredProduct) async {
    try {
      final products = await productRepo.products(filteredProduct);
      emit(ProductSuccess(products));
    } catch (e) {
      if (e is DioException) {
        emit(ProductFailure(ServerFailure.fromDioException(e).errorMessage));
      } else {
        emit(ProductFailure(e.toString()));
      }
    }
  }
}