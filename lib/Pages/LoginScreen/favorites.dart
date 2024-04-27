import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix/bloc/cart/cart_cubit.dart';
import 'package:netflix/bloc/client/client_cubit.dart';
import 'package:netflix/bloc/products/products_cubit.dart';

late ProductsCubit productsCubit;
late CartCubit cartCubit;
late ClientCubit clientCubit;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
          ),
        ),
      ),
      body:
          BlocBuilder<ProductsCubit, ProductsState>(builder: (context, State) {
        return SizedBox.expand(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: State.favorites.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(1.0),
              ),
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        State.favorites[index]["photo"].toString(),
                        height: 90,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(State.favorites[index]["name"].toString()),
                          if (productsCubit
                              .isFavorite(State.favorites[index]["id"] as int))
                            IconButton(
                                onPressed: () {
                                  productsCubit.removeFromFavorites(
                                      State.favorites[index]["id"] as int);
                                  showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text("Sepet"),
                                      content:
                                          Text("Ürün Favorilerden Kaldırıldı"),
                                    ),
                                  );
                                },
                                icon: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(" Favoriden Kaldır")
                                  ],
                                ))
                          else
                            IconButton(
                                onPressed: () {
                                  productsCubit
                                      .addToFavorites(State.favorites[index]);
                                },
                                icon: const Icon(Icons.favorite_border))
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartCubit.sepeteEkle(
                          id: State.favorites[index]["id"] as int,
                          photo: State.favorites[index]["photo"].toString(),
                          ad: State.favorites[index]["name"].toString(),
                          sayi: 1,
                          fiyat: State.favorites[index]["price"] as double);

                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text("Sepet"),
                          content: Text("Ürün Sepete Eklendi"),
                        ),
                      );
                    },
                    child: Text("Sepete Ekle"),
                  ),
                  if (State.favorites[index]["in-stock"] as bool)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_box),
                            const Text("Mevcut"),
                          ],
                        ),
                        Text(
                            State.favorites[index]["price"].toString() + " TL"),
                      ],
                    )
                  else
                    const Row(
                      children: [
                        Icon(Icons.error),
                        Text("Mevcut Değil"),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
