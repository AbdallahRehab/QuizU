
import 'package:flutter/material.dart';





class Routes {
  static const String splashScreen = '/splash_screen';
  static const String onBoardingScreen = '/onBoarding_screen';
  static const String homeScreen = '/home';
  static const String signIn = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String blogListScreen = '/blog_list_screen';
  static const String blogDetailsScreen = '/blog_details_screen';
  static const String aboutUsScreen = '/about_us_screen';

  // static const String myOrders = '/my_orders';
  static const String cartScreen = '/cart_screen';
  static const String exploreScreen = '/explore_screen';
  static const String productDetailsScreen = '/product_details_screen';
  static const String checkOutScreen = '/check_out_screen';
  static const String ordersScreen = '/OrdersScreen';
  static const String orderDetail = '/OrderHistoryDetailScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      // case Routes.splashScreen:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case Routes.onBoardingScreen:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      // case Routes.homeScreen:
      //   return MaterialPageRoute(builder: (_) => const HomeIndexScreen());
      // case Routes.signIn:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case Routes.signUpScreen:
      //   return MaterialPageRoute(builder: (_) => const SingUpScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Not Found'),
        ),
        body: const Center(
          child: Text('This Rout Is Not Found'),
        ),
      ),
    );
  }
}
