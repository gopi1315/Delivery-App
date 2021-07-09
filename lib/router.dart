import 'package:delivery_app/model/cart_model.dart';
import 'package:delivery_app/views/cart_screen.dart';
import 'package:delivery_app/views/dashboard.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class NavigationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => Dashboard());

      case CartScreen.routeName :
        CartModel argument = args as CartModel;
        return MaterialPageRoute(builder: (_) => CartScreen(foodTitle: argument.foodTitle,counter: argument.count,price: argument.price,totalPrice: argument.totalCost,image: argument.image,));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
