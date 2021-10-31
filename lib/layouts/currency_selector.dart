import 'dart:convert';

import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({Key? key}) : super(key: key);

  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  Widget appBarTitle = Text(
    'Currency Selector',
    maxLines: 2,
    softWrap: true,
  );

  Icon icon = Icon(
    Icons.search,
  );

  final globalKey = GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();

  late List _list;

  late bool _isSearching;

  String _searchText = "";

  List searchresult = [];
  late int _searchLength;

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
    _searchLength = _list.length;
  }

  void values() {
    _list = CryptoCurrenciesCubit.instance(context).currencies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: buildAppBar(context),
      body: BlocConsumer<CryptoCurrenciesCubit, CryptoCurrenciesState>(
          listener: (context, state) {},
          builder: (context, state) {
            CryptoCurrenciesCubit cubit =
                CryptoCurrenciesCubit.instance(context);
            if (state is CryptoCurrenciesGetAllSuccess ||
                cubit.currencies.length > 0) {
              if (searchresult.length != 0 || _controller.text.isNotEmpty) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                    width: double.infinity,
                  ),
                  shrinkWrap: true,
                  itemCount: searchresult.length,
                  itemBuilder: (BuildContext context, int index) {
                    // String listData = searchresult[index];
                    // Map <String ,dynamic> dataAsMap= json.decode(listData);
                    Map<String, dynamic> dataAsMap = searchresult[index];
                    return ListTile(
                      dense: true,
                      title: Text(
                        dataAsMap['name'],
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text(dataAsMap['symbol']),
                      onTap: () {
                        cubit.updateMainCurrencyId(dataAsMap['id']);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                    width: double.infinity,
                  ),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    // String listData = _list[index];
                    // Map <String ,dynamic> dataAsMap= json.decode(listData);
                    Map<String, dynamic> dataAsMap = _list[index];

                    return ListTile(
                      dense: true,
                      title: Text(
                        dataAsMap['name'],
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text(dataAsMap['symbol']),
                      onTap: () {
                        cubit.updateMainCurrencyId(dataAsMap['id']);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }
              // return ListView.separated(
              //     separatorBuilder: (context, index) => Container(
              //           height: 1,
              //           color: Colors.grey,
              //           width: double.infinity,
              //         ),
              //     itemCount: cubit.currencies.length,
              //     // itemCount: 25,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         dense: true,
              //         title: Text(
              //           cubit.currencies[index]['name'],
              //           style: Theme.of(context).textTheme.subtitle1,
              //         ),
              //         subtitle: Text(cubit.currencies[index]['symbol']),
              //         onTap: () {
              //           cubit.updateMainCurrencyId(
              //               cubit.currencies[index]['id']);
              //           Navigator.of(context).pop();
              //         },
              //       );
              //     });
            } else if (state is CryptoCurrenciesGetAllLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Center(
                    child: Text('error in fetching coins ...'),
                  ),
                  ElevatedButton(
                    child: Text('Reload'),
                    onPressed: () {
                      CryptoCurrenciesCubit.instance(context)
                          .getAllCurrencies();
                    },
                  ),
                ],
              );
            }
          }),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      title: appBarTitle,
      bottom: AppBar(
        title: FittedBox(
          child: Text(
            'Number of results: $_searchLength',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
        toolbarHeight: 30,
        automaticallyImplyLeading: false,
      ),
      actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            setState(() {
              if (this.icon.icon == Icons.search) {
                this.icon = Icon(
                  Icons.close,
                );
                this.appBarTitle = TextField(
                  autofocus: true,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.none,
                            color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.none,
                            color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.none, color: Colors.transparent),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search...",
                  ),
                  onChanged: (s) {
                    searchOperation(s);
                  },
                  onSubmitted: (s) {
                    searchOperation(s);
                  },
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ],
      toolbarTextStyle: Theme.of(context).textTheme.headline5,
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
      );
      this.appBarTitle = Text(
        "Currency Selector",
        style: Theme.of(context).textTheme.headline5,
      );
      searchresult = [];
      _isSearching = false;
      _controller.clear();
      _searchLength = _list.length;
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data =
            _list[i]['name'].toString() + _list[i]['symbol'].toString();
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(_list[i]);
        }
      }
      setState(() {
        _isSearching = false;
        print('Search length: ${searchresult.length}');

        _searchLength = searchresult.length;
      });
    }
  }
}
