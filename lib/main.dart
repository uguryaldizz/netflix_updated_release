import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix/bloc/cart/cart_cubit.dart';
import 'package:netflix/bloc/client/client_cubit.dart';
import 'package:netflix/bloc/products/products_cubit.dart';

import 'package:netflix/core/themes.dart';
import 'Pages/MainPage/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ClientCubit(
                  ClientState(darkMode: false, language: "en"),
                )),
        BlocProvider(
            create: (context) => CartCubit(
                  CartState(sepet: []),
                )),
        BlocProvider(
            create: (context) => ProductsCubit(
                  ProductsState(favorites: []),
                )),
      ],
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp(
          title: 'Netflix',
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const screen(),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          //localizationsDelegates: const [
          // AppLocalizations.delegate,
          //  GlobalMaterialLocalizations.delegate,
          //  GlobalCupertinoLocalizations.delegate,
          //  GlobalWidgetsLocalizations.delegate,
          //  ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
