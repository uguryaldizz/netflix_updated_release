import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix/Pages/LoginScreen/favorites.dart';
import 'package:netflix/bloc/cart/cart_cubit.dart';
import 'package:netflix/bloc/client/client_cubit.dart';
import 'package:netflix/bloc/products/products_cubit.dart';

late ProductsCubit productsCubit;
late CartCubit cartCubit;
late ClientCubit clientCubit;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String value = 'Göz at';
  var items = [
    'Göz at',
    'Diziler',
    'Filmler',
    'Yeni ve Popüler',
    'Listem',
    'Dile Göz At'
  ];
  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            //netflix iconu
            title: Row(
              children: [
                Image.asset(
                  'assets/images/netflix_logo.png',
                  height: 20,
                  width: 80,
                ),
                SizedBox(width: 20),
                DropdownButton(
                  underline: SizedBox(),
                  value: value,
                  //icon: ,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? new_value) {
                    setState(() {
                      value = new_value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritesScreen()),
                  );
                },
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, State) {
        return SizedBox.expand(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: State.sepet.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        State.sepet[index]["photo"].toString(),
                        height: 90,
                      ),
                      SizedBox(height: 120.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(State.sepet[index]["count"].toString() + "x",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text(State.sepet[index]["name"].toString()),
                              SizedBox(width: 12.0),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                cartCubit.sepettenCikart(
                                    id: State.sepet[index]["id"] as int);
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Text("Sepet"),
                                    content: Text("Ürün Sepetten Çıkarıldı"),
                                  ),
                                );
                              },
                              icon: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_bag),
                                  SizedBox(width: 12.0),
                                  Text("Sepetten Çıkart",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                  if (State.sepet[index]["in-stock"] as bool)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_box),
                            SizedBox(width: 10.0),
                            const Text("Stokta Var"),
                          ],
                        ),
                        Text(State.sepet[index]["price"].toString() + " ₺"),
                      ],
                    )
                  else
                    const Row(
                      children: [
                        Icon(Icons.error),
                        Text("Mevcut Degil"),
                      ],
                    ),
                  const Divider(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
