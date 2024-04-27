import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix/Pages/LoginScreen/cart.dart';
import 'package:netflix/Pages/LoginScreen/favorites.dart';
import 'package:netflix/bloc/cart/cart_cubit.dart';
import 'package:netflix/bloc/client/client_cubit.dart';
import 'package:netflix/bloc/products/products_cubit.dart';

var products = [
  {
    "id": 1,
    "name": "   Netflix Temel Plan (Aylık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940",
    "price": 100.00,
  },
  {
    "id": 2,
    "name": "   Netflix Standard Plan (Aylık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940",
    "price": 230.00,
  },
  {
    "id": 3,
    "name": "   Netflix Özel Plan (Aylık) ",
    "in-stock": false,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940",
    "price": 400.00,
  },
  {
    "id": 4,
    "name": "   Netflix Özel Plan (Yıllık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940",
    "price": 4199.00,
  }
];
late ProductsCubit productsCubit;
late CartCubit cartCubit;
late ClientCubit clientCubit;

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,

              //netflix iconu
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/netflix_logo.png',
                    height: 20,
                    width: 80,
                  ),
                  SizedBox(width: 20),
                ],
              ),
              actions: [
                if (clientCubit.state.darkMode)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {
                          clientCubit.changeDarkMode(darkMode: false);
                        },
                        icon: Icon(Icons.sunny)),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {
                          clientCubit.changeDarkMode(darkMode: true);
                        },
                        icon: Icon(Icons.nightlight)),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: IconButton(
                    onPressed: () {
                      if (clientCubit.state.language == "tr") {
                        clientCubit.changeLanguage(language: "en");
                      } else {
                        clientCubit.changeLanguage(language: "tr");
                      }
                    },
                    icon: Icon(Icons.language),
                  ),
                ),
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
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()),
                    );
                  },
                  icon: Icon(Icons.shopping_bag),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 120,
                    height: 40,
                    color: const Color.fromARGB(255, 229, 9, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'UĞUR ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Icon(
                          Icons.person_2,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, State) {
          return SizedBox.expand(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(14.0),
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Image.network(products[index]["photo"].toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(products[index]["name"].toString()),
                        if (productsCubit
                            .isFavorite(products[index]["id"] as int))
                          IconButton(
                              onPressed: () {
                                productsCubit.removeFromFavorites(
                                    products[index]["id"] as int);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Color.fromARGB(255, 255, 20, 3),
                              ))
                        else
                          IconButton(
                              onPressed: () {
                                productsCubit.addToFavorites(products[index]);
                              },
                              icon: const Icon(Icons.favorite_border))
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cartCubit.sepeteEkle(
                            id: products[index]["id"] as int,
                            photo: products[index]["photo"].toString(),
                            ad: products[index]["name"].toString(),
                            sayi: 1,
                            fiyat: products[index]["price"] as double);

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
                    if (products[index]["in-stock"] as bool)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_box),
                              const Text("Mevcut"),
                            ],
                          ),
                          Text(products[index]["price"].toString() + " TL"),
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
    });
  }
}
