import 'package:filterapi/Application/Services/NavigationServices/navigation.dart';
import 'package:filterapi/Domain/Models/carts_model.dart';
import 'package:filterapi/Domain/Models/products_model.dart';
import 'package:filterapi/Presentation/Widgets/Cart/Components/filter_bottom_sheet.dart';
import 'package:filterapi/Presentation/Widgets/Cart/Controller/cart_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Cart/State/cart_state.dart';
import 'package:filterapi/Presentation/Widgets/Cart/State/test.dart';
import 'package:filterapi/Presentation/Widgets/Product/Controller/product_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Product/Controller/single_product_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Product/State/product_state.dart';
import 'package:filterapi/Presentation/Widgets/Product/State/single_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartsScreen extends StatefulWidget {
  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  late ScrollController _scrollController;
  TextEditingController _searchController = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier<String>("");
  ValueNotifier<List<bool>> selectedCarts = ValueNotifier<List<bool>>([]); 

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<CartsCubit>().getCubitCartsData();
    context.read<ProductsCubit>().getCubitProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: TextField(
              controller: _searchController,
              onChanged: (searchValue) {
                context
                    .read<SingleProductCubit>()
                    .getCubitSingleProductData(keyword: searchValue);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => FilterBottomSheet());
                  },
                ),
                hintText: 'Search Product',
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<String>(
            valueListenable: searchNotifier,
            builder: (BuildContext context, value, Widget? child) {
              return Container();
            },
          ),





          BlocConsumer<SingleProductCubit, SingleProductstate>(
            builder: (context, state) {
              print('state of single product is $state');
              if (state is SingleProductLoadedState) {
                print('stae of single product is loaded ');
                return Container(
                  height: 60,
                  width: 60,
                  child: (Image.network(state.imageurl)),
                );
              } else {
                if (state is ProductEmptyState) {
                  return SizedBox(child: Text('No products'));
                }
                return Text('No products');
              }
              
            },
            listener: (context, state) {},
          ),



          BlocConsumer<CartsCubit, CartState>(
            listener: (context, state) {
              if (state is CartLoadedState) {
                Future.delayed(Duration.zero).whenComplete(() {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              }
            },
            builder: (context, state) {
              if (state is CartLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartLoadedState) {
                List<Carts> carts = state.loadedCarts;
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: carts.length,
                          itemBuilder: (context, index) {
                            Carts cart = carts[index];
                            return Dismissible(
                              onDismissed: (direction) {
                                context
                                    .read<CartsCubit>()
                                    .deleteCubitCartsData(cart.id);
                              },
                              background: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Container(
                                  color: Colors.red,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              key: Key(cart.id.toString()),
                              child: Card(

                                margin: EdgeInsets.all(08.0),
                                child: GestureDetector(
                                  onLongPress: (){
                                    Navigate.to(context, Test());
                                    

                                  },
                                  child: ExpansionTile(
                                    initiallyExpanded: false,
                                    backgroundColor: Colors.amber,
                                    title: Text('Cart no' + cart.id.toString()),
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cart.products!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                  
                                              
                                          Product product = cart.products![index];
                                          return ListTile(
                                            trailing: GestureDetector(
                                              onTap: () {
                                                context.read<CartsCubit>().deleteCubitCartsProduct(product.productId, cart.id);
                                              },
                                              child: Icon(Icons.close)),
                                            title: GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<ProductsCubit>()
                                                    .getCubitProductsData();
                                                _openDialog(context,
                                                    product.productId!);
                                              },
                                              child: Text(
                                                  'Id: ${product.productId}'),
                                            ),
                                            subtitle: Text(
                                                'quantity: ${product.quantity}'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is CartErrorState) {
                return Center(
                  child: Text('Error loading Carts'),
                );
              } else {
                return Center(
                  child: Text('Unknown state'),
                );
              }
            },
          ),








        ],
      ),
    );
  }

  void _openDialog(BuildContext context, int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<ProductsCubit, Productstate>(
          listener: (context, state) {},
          builder: (context, state) {
            return AlertDialog(
              title: Text('Alert'),
              content: BlocBuilder<ProductsCubit, Productstate>(
                builder: (context, state) {
                  if (state is ProductLoadedState) {
                    List<Products> prods = state.loadedProducts!;
                    Products? selectedProduct = prods.firstWhere(
                      (prod) => prod.id == productId,
                    );
                    if (selectedProduct != null) {
                      return Image.network(selectedProduct.image!);
                    } else {
                      return Text('Product not found');
                    }
                  } else if (state is ProductErrorState) {
                    return Text('Error');
                  } else {
                    return Container(child: Text('Nothing'));
                  }
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
    @override
    void dispose() {
      _scrollController.dispose();
      _searchController.dispose();
      searchNotifier.dispose();
      super.dispose();
    }
  }
}
