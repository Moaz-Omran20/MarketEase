import '../models/category_model.dart';

abstract class CategoryRepo
{
  Future<List<CategoryModel>> getCategories() ;
}