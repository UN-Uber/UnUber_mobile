// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

// Project imports:
import '../ui/views/credit_card/credit_card_list/credit_card_list_view.dart';
import '../ui/views/credit_card/new_credit_card/new_credit_card_view.dart';
import '../ui/views/forgot_password/forgot_password_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/start';
  static const String loginView = '/login';
  static const String homeView = '/home';
  static const String forgotPasswordView = '/forgot';
  static const String newCreditCardView = '/new-credit-card';
  static const String creditCardsListView = '/my-cards';
  static const all = <String>{
    startupView,
    loginView,
    homeView,
    forgotPasswordView,
    newCreditCardView,
    creditCardsListView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.newCreditCardView, page: NewCreditCardView),
    RouteDef(Routes.creditCardsListView, page: CreditCardsListView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ForgotPasswordView(),
        settings: data,
      );
    },
    NewCreditCardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NewCreditCardView(),
        settings: data,
      );
    },
    CreditCardsListView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CreditCardsListView(),
        settings: data,
      );
    },
  };
}
