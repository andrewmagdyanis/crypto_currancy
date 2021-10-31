import 'package:crypto_currancy/layouts/currency_selector.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController mainCurrencyController;
  final TextEditingController amountController;

  const InputWidget({
    Key? key,
    required this.mainCurrencyController,
    required this.amountController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(8),
        elevation: 3,
        // shadowColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            // color: Colors.green.shade400.withOpacity(0.5),
            // borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<CryptoCurrenciesCubit,
                          CryptoCurrenciesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        CryptoCurrenciesCubit cubit =
                            CryptoCurrenciesCubit.instance(context);
                        mainCurrencyController.value = TextEditingValue(
                            text: cubit.selectedMainCurrencyId);
                        return TextFormField(
                          controller: mainCurrencyController,
                          readOnly: true,
                          focusNode: FocusScopeNode(skipTraversal: true),
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.black12.withOpacity(0.05),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 20),
                            labelText: 'First Main Currency',
                            isCollapsed: false,
                            hintText: 'ex: bitcoin',
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                            helperText: 'click to select the currency',
                            helperStyle: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontStyle: FontStyle.italic),
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onTap: () {
                            print('clicked');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CurrencySelector()),
                            );
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'please select the main currency';
                            } else {
                              return null;
                            }
                          },
                        );
                      }),
                ),
              ),
              Spacer(),
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<CryptoCurrenciesCubit,
                          CryptoCurrenciesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        CryptoCurrenciesCubit cubit =
                            CryptoCurrenciesCubit.instance(context);

                        amountController.value =
                            TextEditingValue(text: cubit.amount);

                        return TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.black12.withOpacity(0.05),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 20),
                            labelText: 'Amount',
                            isCollapsed: false,
                            hintText: 'ex: bitcoin',
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                            helperText: 'enter amount',
                            helperStyle: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontStyle: FontStyle.italic),
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          toolbarOptions: ToolbarOptions(copy: true),
                          onFieldSubmitted: (s) {
                            cubit.updateAmount(s);
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter the amount';
                            } else {
                              return null;
                            }
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
