import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/core/shared_widgets/product_loading.dart';
import 'package:market_ease/features/home/data/models/category_model.dart';

import '../../../../../generated/assets.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Center(
                  child: SizedBox(
                    width: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        fit: BoxFit.fill,
                        Assets.imagesWomenFashion,
                      ),
                    ),
                  ),
                ),
                imageUrl: category.image ?? "",
                placeholder: (context, url) => Center(child: ProductLoading()),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Expanded(
          child: Text(
            category.name ?? "",
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
