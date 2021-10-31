import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutputResult extends StatelessWidget {
  final TextEditingController resultController;

  const OutputResult({
    Key? key,
    required this.resultController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child:  Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(8),
        elevation: 3,
        // shadowColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          // margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            // color: Colors.lightGreen.withOpacity(0.7),
            // borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            CryptoCurrenciesCubit cubit =
                                CryptoCurrenciesCubit.instance(context);
                            List<DropdownMenuItem<String>>? l =
                                (state is CryptoCurrenciesGetVsSuccess ||
                                        cubit.vsCurrencies.length > 0)
                                    ? cubit.vsCurrencies
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(
                                              e,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            value: e.toString(),
                                            onTap: () {
                                              print(e);
                                            },
                                          ),
                                        )
                                        .toList()
                                    : [];
                            return DropdownButtonFormField(

                              style: Theme.of(context).textTheme.bodyText2,

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
                                labelText: 'Second VS Currency',
                                isCollapsed: false,
                                hintText: 'ex: eth',
                                hintStyle: Theme.of(context).textTheme.bodyText2,
                                helperText: 'choose supported vs currency',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontStyle: FontStyle.italic),
                                alignLabelWithHint: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              items: l,
                              onChanged: (String? s) {
                                if (s != null && s != '')
                                  cubit.updateVsCurrencyId(s);
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
                  child:
                      BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            CryptoCurrenciesCubit cubit =
                                CryptoCurrenciesCubit.instance(context);
                            resultController.value =
                                TextEditingValue(text: cubit.result);
                            return TextFormField(
                              controller: resultController,
                              readOnly: true,
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
                                labelText: 'Result',
                                isCollapsed: false,
                                // hintText: 'ex: bitcoin',
                                hintStyle: Theme.of(context).textTheme.bodyText2,
                                // helperText: 'click to select the currency',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontStyle: FontStyle.italic),
                                alignLabelWithHint: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
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
