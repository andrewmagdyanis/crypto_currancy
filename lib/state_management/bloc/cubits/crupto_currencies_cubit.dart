import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:crypto_currancy/constants.dart';
import 'package:crypto_currancy/helpers/dio_helper.dart';
import 'package:crypto_currancy/state_management/model/marketCurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part '../states/crupto_currencies_state.dart';

class CryptoCurrenciesCubit extends Cubit<CryptoCurrenciesState> {
  CryptoCurrenciesCubit() : super(CryptoCurrenciesInitial());

  static CryptoCurrenciesCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  List<dynamic> vsCurrencies = [];

  Future<void> getAllVsCurrencies(context) async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    bool isConnected = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (isConnected) {
      print('connected');
      emit(CryptoCurrenciesGetVsLoading());
      String url = '/simple/supported_vs_currencies';
      Map<String, dynamic> query = {};
      DioHelper.getData(url, query).then((value) {
        print(value);
        print('value.data:${value.data}');
        print(value.data.runtimeType);
        print(value.data.length);
        vsCurrencies = value.data;
        emit(CryptoCurrenciesGetVsSuccess());
      }).catchError((e) {
        print('error in getVsCryptoCurrencies: $e');
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
        emit(CryptoCurrenciesGetVsFailed(errorMessage));
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text('Please check your network adaptor'),
              actions: [
                ElevatedButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
    }
  }

  List<dynamic> currencies = [];

  Future<void> getAllCurrencies() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    bool isConnected = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (isConnected) {
      print('connected');

      emit(CryptoCurrenciesGetAllLoading());

      String url = '/coins/list';
      Map<String, dynamic> query = {};
      DioHelper.getData(url, query).then((value) {
        print(value);
        print('value.data:${value.data}');
        print(value.data.runtimeType);
        print(value.data.length);
        currencies = value.data;
        emit(CryptoCurrenciesGetAllSuccess());
      }).catchError((e) {
        print('error in getAllCryptoCurrencies: $e');
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
        emit(CryptoCurrenciesGetAllFailed(errorMessage));
      });
    }
  }

  String selectedVsCurrencyId2 = 'usd';

  void updateVsCurrencyId2(String id) {
    selectedVsCurrencyId2 = id;
    emit(CryptoCurrenciesSelectVsCurrency2());
  }

  int resultSize = 25;

  void updateResultSize(String size) {
    resultSize = int.parse(size.toString());
    emit(CryptoCurrenciesResultSize());
  }

  List<MarketCurrency> marketCurrencies = [];

  Future<void> getAllMarketCurrencies() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    bool isConnected = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (isConnected) {
      print('connected');

      emit(CryptoCurrenciesGetMarketLoading());

      String url = '/coins/markets';
      Map<String, dynamic> query = {
        "vs_currency": selectedVsCurrencyId2,
        "per_page": resultSize,
      };
      DioHelper.getData(url, query).then((value) {
        print(value);
        print('value.data:${value.data}');
        print(value.data.runtimeType);
        print(value.data.length);

        marketCurrencies = [];
        (value.data as List).forEach((element) {
          marketCurrencies.add(MarketCurrency.fromJson(element));
        });
        emit(CryptoCurrenciesGetMarketSuccess());
      }).catchError((e) {
        print('error in getMarketCryptoCurrencies: $e');
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
        emit(CryptoCurrenciesGetMarketFailed(errorMessage));
      });
    }
  }

  String selectedMainCurrencyId = '';

  void updateMainCurrencyId(String id) {
    selectedMainCurrencyId = id;
    emit(CryptoCurrenciesSelectMainCurrency());
  }

  String selectedVsCurrencyId = '';

  void updateVsCurrencyId(String id) {
    selectedVsCurrencyId = id;
    emit(CryptoCurrenciesSelectVsCurrency());
  }

  String amount = '0';

  void updateAmount(String a) {
    amount = a;
    print('amount updated to be: $amount');
    emit(CryptoCurrenciesSelectAmount());
  }

  String result = '';

  Future<void> makeExchange(BuildContext context) async {
    print('amount: $amount');
    print('Main currency: $selectedMainCurrencyId');
    print('Vs currency: $selectedVsCurrencyId');
    Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    bool isConnected = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (isConnected) {
      emit(CryptoCurrenciesExchangeLoading());
      Map<String, dynamic> queryParameters = {
        'ids': selectedMainCurrencyId,
        'vs_currencies': selectedVsCurrencyId,
      };
      DioHelper.getData('/simple/price', queryParameters).then((value) {
        print('returned value is : ${value.data}');
        double amt = double.tryParse(amount) ?? 1.0;
        print('amt:$amt');
        double exchangeRate = double.tryParse(value.data[selectedMainCurrencyId]
                    [selectedVsCurrencyId]
                .toString()) ??
            1.0;
        result = (exchangeRate * amt).toString();
        emit(CryptoCurrenciesExchangeSuccess());
      }).catchError((e) {
        print('error in makeExchange: $e');
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
        emit(CryptoCurrenciesExchangeFailed(errorMessage));
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text('Please check your network adaptor'),
              actions: [
                ElevatedButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
    }
  }
}
