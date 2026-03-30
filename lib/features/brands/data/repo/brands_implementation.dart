import 'package:market_ease/core/data_source/remote/api_service.dart';
import 'package:market_ease/features/brands/data/models/brand_model.dart';
import 'package:market_ease/features/brands/data/repo/brands_repo.dart';

import '../../../../core/data_source/remote/api_config.dart';

class BrandsImplementation extends BrandsRepo{

  BrandsImplementation(this.apiService);


 ApiService apiService;

  @override
  Future<List<BrandModel>> getBrands() async{
    // TODO: implement getBrands
    final response = await apiService.get(endPoint: ApiEndPoints.brands);
    List<BrandModel>brands = [];
    for(var item in response.data["data"]){
      brands.add(BrandModel.fromJson(item));
    }
    return brands;

  }




}