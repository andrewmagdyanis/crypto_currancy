import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currancy/layouts/platform_web_view.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:crypto_currancy/state_management/model/financePlatform.dart';
import 'package:crypto_currancy/state_management/model/marketCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PlatformsScreen extends StatefulWidget {
  const PlatformsScreen({Key? key}) : super(key: key);

  @override
  _PlatformsScreenState createState() => _PlatformsScreenState();
}

class _PlatformsScreenState extends State<PlatformsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: Text(
          'Popular Finance Platforms',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 18,
              ),
        ),
      ),
      body: BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
          listener: (context, state) {},
          buildWhen: (oldS, newS) {
            if (newS is CryptoCurrenciesSelectVsCurrency2) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            CryptoCurrenciesCubit cubit =
                CryptoCurrenciesCubit.instance(context);
            if (state is CryptoCurrenciesGetPlatformsSuccess ||
                cubit.financePlatforms.length > 0) {
              List<FinancePlatform> financePlatforms = cubit.financePlatforms;
              print(financePlatforms.length);
              return ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                  width: double.infinity,
                ),
                shrinkWrap: true,
                itemCount: financePlatforms.length,
                itemBuilder: (BuildContext context, int index) {
                  FinancePlatform financePlatform = financePlatforms[index];

                  Color c =
                      financePlatform.centralized ? Colors.green : Colors.red;
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${financePlatform.name}'),
                      ],
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category: ${financePlatform.category}',
                            semanticsLabel: ',',
                            maxLines: 3,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Url: ${financePlatform.website_url}',
                            semanticsLabel: ',',
                            maxLines: 3,
                          ),
                        ]),
                    trailing: Container(
                      width: 45,
                      child: Column(children: [
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              '${(financePlatform.centralized) ? 'centralized' : 'un-centralized'}',
                              style: TextStyle(fontSize: 12, color: c),
                            ),
                          ),
                        ),
                        Icon(
                          (financePlatform.centralized)
                              ? Icons.center_focus_strong
                              : Icons.center_focus_strong_outlined,
                          color: c,
                        )
                      ]),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return PlatformWebView(
                            financePlatform: financePlatform,
                          );
                        }),
                      );
                    },
                  );
                },
              );
            } else if (state is CryptoCurrenciesGetPlatformsFailed) {
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
