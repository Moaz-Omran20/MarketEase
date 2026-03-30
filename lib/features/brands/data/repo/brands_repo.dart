import 'package:market_ease/features/brands/data/models/brand_model.dart';

abstract class BrandsRepo {

  Future<List<BrandModel>> getBrands();

}