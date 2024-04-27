import 'package:go_router/go_router.dart';
import 'package:netflix/Pages/LoginScreen/favorites.dart';
import 'package:netflix/core/error.dart';

import '../Pages/LoginScreen/cart.dart';

final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: "/cart",
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: "/favori",
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);
