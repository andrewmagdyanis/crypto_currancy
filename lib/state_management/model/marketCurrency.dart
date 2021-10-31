class MarketCurrency {
/*
{"id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 61518,
    "market_cap": 1163409368495,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1295490415185,
    "total_volume": 34779765133,
    "high_24h": 62939,
    "low_24h": 61182,
    "price_change_24h": 283.44,
    "price_change_percentage_24h": 0.46288,
    "market_cap_change_24h": 9088485448,
    "market_cap_change_percentage_24h": 0.78734,
    "circulating_supply": 18858956,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 67277,
    "ath_change_percentage": -8.30416,
    "ath_date": "2021-10-20T14:54:17.702Z",
    "atl": 67.81,
    "atl_change_percentage": 90876.15327,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2021-10-30T14:18:21.139Z"
}
*/
  late String? id;
  late String? symbol;
  late String? name;
  late String? image;
  late num? current_price;
  late num? market_cap;
  late int? market_cap_rank;
  late num? fully_diluted_valuation;
  late num? total_volume;
  late num? high_24h;
  late num? low_24h;
  late num? price_change_24h;
  late num? price_change_percentage_24h;
  late num? market_cap_change_24h;
  late num? market_cap_change_percentage_24h;
  late num? circulating_supply;
  late num? total_supply;
  late num? max_supply;
  late num? ath;
  late num? ath_change_percentage;
  late DateTime? ath_date; //2021-10-20T14:54:17.702Z",
  late num? atl;
  late num? atl_change_percentage;
  late DateTime? atl_date; // 2013-07-06T00:00:00.000Z",
  late Map<String, dynamic>? roi;
  late DateTime? last_updated;

  MarketCurrency.fromJson(json) {
    id = json["id"];
    symbol = json["symbol"];
    name = json["name"];
    image = json["image"];
    current_price = json["current_price"];
    market_cap = json["market_cap"];
    market_cap_rank = json["market_cap_rank"];
    fully_diluted_valuation = json["fully_diluted_valuation"];
    total_volume = json["total_volume"];
    high_24h = json["high_24h"];
    low_24h = json["low_24h"];
    price_change_24h = json["price_change_24h"];
    price_change_percentage_24h = json["price_change_percentage_24h"];
    market_cap_change_24h = json["market_cap_change_24h"];
    market_cap_change_percentage_24h = json["market_cap_change_percentage_24h"];
    circulating_supply = json["circulating_supply"];
    total_supply = json["total_supply"];
    max_supply = json["max_supply"];
    ath = json["ath"];
    ath_change_percentage = json["ath_change_percentage"];
    ath_date = DateTime.parse(
        json["ath_date"].toString()); //2021-10-20T14:54:17.702Z",
    atl = json["atl"];
    atl_change_percentage = json["atl_change_percentage"];
    atl_date = DateTime.parse(
        json["atl_date"].toString()); // 2013-07-06T00:00:00.000Z",
    roi = json["roi"];
    last_updated = DateTime.parse(json["last_updated"].toString());
  }
}
