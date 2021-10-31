import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:crypto_currancy/state_management/model/marketCurrency.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

class MarketPriceScreen extends StatefulWidget {
  const MarketPriceScreen({Key? key}) : super(key: key);

  @override
  _MarketPriceScreenState createState() => _MarketPriceScreenState();
}

class _MarketPriceScreenState extends State<MarketPriceScreen> {
  bool filterOpen = false;
  TextEditingController controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var marketCapFormatter = NumberFormat('###,###,###,###,000.00');
    var priceFormatter = NumberFormat('###,###,###,###,##0.00');
    var percentageFormatter = NumberFormat('0.00');
    CryptoCurrenciesCubit cubit = CryptoCurrenciesCubit.instance(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Top ${cubit.resultSize} crypto currency\npriced by ${cubit.selectedVsCurrencyId2.toUpperCase()}',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await SuperEasyPermissions.askPermission(Permissions.storage);
              bool checkPermission =
                  await SuperEasyPermissions.isGranted(Permissions.storage);
              if (checkPermission) {
                // var path = await ExternalPath.getExternalStoragePublicDirectory(
                //     ExternalPath.DIRECTORY_DOWNLOADS);
                Directory dir = await getApplicationDocumentsDirectory();
                // String file = "${dir.path}/";
                String fileName =
                    'top${cubit.resultSize}_in_${cubit.selectedVsCurrencyId2}.csv';
                File f = File(dir.path + "/$fileName");

                List<List<dynamic>> rows = [];
                List<dynamic> row = [];

                row.add('market_cap_rank');
                row.add('name');
                row.add('symbol');
                row.add('current_price');
                row.add('price_change_percentage_24h');

                cubit.marketCurrencies.forEach((element) {
                  row.add(element.market_cap_rank);
                  row.add(element.name);
                  row.add(element.symbol);
                  row.add(element.current_price);
                  row.add(element.price_change_percentage_24h);

                  rows.add(row);
                });

                String csv = const ListToCsvConverter().convert(rows);
                f.writeAsString(csv).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'file $fileName downloaded in:\n${dir.path}',
                        style: Theme.of(context).textTheme.subtitle1,

                      ),
                      action: SnackBarAction(
                        label: 'open',
                        onPressed: () {

                          OpenFile.open(dir.path + "/$fileName");
                        },
                      ),
                    ),
                  );
                });
              }
            },
          )
        ],
        leading: !filterOpen
            ? IconButton(
                onPressed: () {
                  setState(() {
                    filterOpen = true;
                  });
                },
                icon: Icon(Icons.filter_alt_sharp),
              )
            : Container(),
        bottom: filterOpen
            ? AppBar(
                toolbarHeight: 80,
                title: Form(
                  key: formKey,
                  child: Container(
                    width: double.infinity,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 100,
                            child: TextFormField(
                              controller: controller,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black12.withOpacity(0.05),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 16),
                                labelText: 'Result Size',
                                isCollapsed: false,
                                hintText: 'ex: 100',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                // helperText: 'click to select the currency',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontStyle: FontStyle.italic),
                                alignLabelWithHint: true,

                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              keyboardType: TextInputType.number,
                              // onChanged: (s) {
                              //   // print('onChanged: ${s} ${controller.value.text} ${controller.text}');
                              //   cubit.updateResultSize(s);
                              // },
                              onSaved: (s) {
                                cubit.updateResultSize(s!);
                              },

                              // onFieldSubmitted: (s) {
                              //   print('onFieldSubmitted');
                              //
                              //   cubit.updateResultSize(s);
                              //
                              // },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 100,
                            child: BlocConsumer<CryptoCurrenciesCubit,
                                    CryptoCurrenciesState>(
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      filled: true,
                                      fillColor:
                                          Colors.black12.withOpacity(0.05),
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(fontSize: 16),
                                      labelText: 'Price Currency',
                                      isCollapsed: false,
                                      hintText: 'ex: usd',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      helperStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontStyle: FontStyle.italic),
                                      alignLabelWithHint: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    items: l,
                                    onChanged: (String? s) {
                                      if (s != null && s != '')
                                        cubit.updateVsCurrencyId2(s);
                                    },
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            formKey.currentState!.save();
                            cubit.getAllMarketCurrencies();
                            setState(() {
                              filterOpen = false;
                            });
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : AppBar(
                toolbarHeight: 0,
              ),
      ),
      body: BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
          listener: (context, state) {},
          builder: (context, state) {
            CryptoCurrenciesCubit cubit =
                CryptoCurrenciesCubit.instance(context);
            if (state is CryptoCurrenciesGetMarketSuccess ||
                cubit.marketCurrencies.length > 0) {
              List<MarketCurrency> marketCurrencies = cubit.marketCurrencies;
              print(marketCurrencies.length);
              return ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                  width: double.infinity,
                ),
                shrinkWrap: true,
                itemCount: marketCurrencies.length,
                itemBuilder: (BuildContext context, int index) {
                  MarketCurrency currency = marketCurrencies[index];

                  Color c = currency.price_change_percentage_24h! > 0
                      ? Colors.green
                      : Colors.red;
                  return ListTile(
                    leading: Container(
                      width: 82,
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            currency.market_cap_rank.toString(),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.all(4),
                          child: CachedNetworkImage(
                              imageUrl: currency.image!, fit: BoxFit.cover),
                        ),
                      ]),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${marketCurrencies[index].name!} (${marketCurrencies[index].symbol!})'),
                        Text(
                          'Price: ${priceFormatter.format(marketCurrencies[index].current_price)} ${cubit.selectedVsCurrencyId2}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      'MarketCap: ${marketCapFormatter.format(currency.market_cap)} ${cubit.selectedVsCurrencyId2}',
                      semanticsLabel: ',',
                      maxLines: 3,
                    ),
                    trailing: Container(
                      width: 45,
                      child: Column(children: [
                        Text(
                          '${percentageFormatter.format(currency.price_change_percentage_24h)}%',
                          maxLines: 2,
                          style: TextStyle(fontSize: 12, color: c),
                        ),
                        Row(children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                '24h ',
                                style: TextStyle(fontSize: 12, color: c),
                              ),
                            ),
                          ),
                          Icon(
                            (currency.price_change_percentage_24h! > 0)
                                ? Icons.arrow_circle_up_outlined
                                : Icons.arrow_circle_down_outlined,
                            color: c,
                          )
                        ])
                      ]),
                    ),
                  );
                },
              );
            } else if (state is CryptoCurrenciesGetMarketFailed) {
              return Center(
                child: Text('failed'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
