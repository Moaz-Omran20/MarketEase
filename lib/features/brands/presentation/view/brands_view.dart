import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market_ease/core/routes/app_routes.dart';
import 'package:market_ease/core/shared_models/filter_model.dart';
import 'package:market_ease/core/theme/light_colors.dart';
import 'package:market_ease/features/brands/presentation/view_model/brands_cubit.dart';

import '../../../../core/shared_widgets/product_loading.dart';

class BrandsView extends StatelessWidget {
  const BrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 40,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return BlocBuilder<BrandsCubit, BrandsState>(
                    builder: (context, state) {
                      if (state is BrandsSuccess) {
                        return InkWell(
                          onTap: () {
                            context.push(
                              AppRoutes.kAllProductsView,
                              extra: FilterModel(
                                productId: state.brands[index].id!,
                                filterType: "brand",
                                title: state.brands[index].name??"",
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: state.brands[index].image ?? "",
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: LightColors.primaryColor,
                            ),
                            placeholder: (context, url) =>
                                Center(child: ProductLoading()),
                          ),
                        );
                      } else if (state is BrandsFailure) {
                        return Center(child: Text(state.errorMessage));
                      } else {
                        return const Center(child: ProductLoading());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
