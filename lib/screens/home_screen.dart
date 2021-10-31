import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:crypto_currancy/widgets/input_widget.dart';
import 'package:crypto_currancy/widgets/output_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
        listener: (context, state) {
      if (state is CryptoCurrenciesExchangeFailed) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('error message: ${state.errorMsg}'),
                actions: [
                  ElevatedButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      } else if (state is CryptoCurrenciesGetAllFailed) { showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('error message: ${state.errorMsg}'),
              actions: [
                ElevatedButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
      } else if (state is CryptoCurrenciesGetVsFailed) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('error message: ${state.errorMsg}'),
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
    }, builder: (context, state) {
      CryptoCurrenciesCubit cubit = CryptoCurrenciesCubit.instance(context);
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              kTextTabBarHeight,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputWidget(
                amountController: TextEditingController(),
                mainCurrencyController: TextEditingController(),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    cubit.makeExchange(context);
                  },
                  child: Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        state is CryptoCurrenciesExchangeLoading,
                    widgetBuilder: (BuildContext context) =>
                        CircularProgressIndicator(),
                    fallbackBuilder: (BuildContext context) => Text('Convert'),
                  ),
                ),
              ),
              OutputResult(
                resultController: TextEditingController(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
