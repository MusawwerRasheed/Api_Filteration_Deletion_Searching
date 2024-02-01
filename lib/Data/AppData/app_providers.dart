
import 'package:filterapi/Presentation/Widgets/Cart/Controller/cart_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Product/Controller/product_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Product/Controller/single_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appProviders = [

BlocProvider<CartsCubit>(create: (context) => CartsCubit()),
  BlocProvider<ProductsCubit>(create: (context) => ProductsCubit()),
  BlocProvider<SingleProductCubit>(create: (context) => SingleProductCubit()),
];


