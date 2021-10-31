part of '../cubits/crupto_currencies_cubit.dart';

@immutable
abstract class CryptoCurrenciesState {}

class CryptoCurrenciesInitial extends CryptoCurrenciesState {}

//all
class CryptoCurrenciesGetAllLoading extends CryptoCurrenciesState {}

class CryptoCurrenciesGetAllSuccess extends CryptoCurrenciesState {}

class CryptoCurrenciesGetAllFailed extends CryptoCurrenciesState {
  final String errorMsg;

  CryptoCurrenciesGetAllFailed(this.errorMsg);
}

//vs
class CryptoCurrenciesGetVsLoading extends CryptoCurrenciesState {}

class CryptoCurrenciesGetVsSuccess extends CryptoCurrenciesState {}

class CryptoCurrenciesGetVsFailed extends CryptoCurrenciesState {
  final String errorMsg;

  CryptoCurrenciesGetVsFailed(this.errorMsg);
}

//market
class CryptoCurrenciesGetMarketLoading extends CryptoCurrenciesState {}

class CryptoCurrenciesGetMarketSuccess extends CryptoCurrenciesState {}

class CryptoCurrenciesGetMarketFailed extends CryptoCurrenciesState {
  final String errorMsg;

  CryptoCurrenciesGetMarketFailed(this.errorMsg);
}

//selection
class CryptoCurrenciesSelectVsCurrency extends CryptoCurrenciesState {}

class CryptoCurrenciesSelectMainCurrency extends CryptoCurrenciesState {}

class CryptoCurrenciesSelectAmount extends CryptoCurrenciesState {}

//excahnge

class CryptoCurrenciesExchangeLoading extends CryptoCurrenciesState {}

class CryptoCurrenciesExchangeSuccess extends CryptoCurrenciesState {}

class CryptoCurrenciesExchangeFailed extends CryptoCurrenciesState {
  final String errorMsg;

  CryptoCurrenciesExchangeFailed(this.errorMsg);
}

//market
class CryptoCurrenciesResultSize extends CryptoCurrenciesState {}

class CryptoCurrenciesSelectVsCurrency2 extends CryptoCurrenciesState {}
