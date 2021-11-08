class FinancePlatform {
  /*
  [
  {
    "name": "Binance Staking",
    "facts": "",
    "category": "CeFi Platform",
    "centralized": true,
    "website_url": "https://www.binance.com/en/staking"
  },
  {
    "name": "Celsius Network",
    "facts": "",
    "category": "CeFi Platform",
    "centralized": true,
    "website_url": "https://celsius.network/"
  },
  ]
  */

  late String name;
  late String facts;
  late String category;
  late bool centralized;
  late String website_url;

  FinancePlatform({
    required this.name,
    required this.facts,
    required this.category,
    required this.centralized,
    required this.website_url,
  });

  FinancePlatform.fromJson(json) {
    this.name = json['name'];
    this.facts = json['facts'];
    this.category = json['category'];
    this.centralized = json['centralized'];
    this.website_url = json['website_url'];
  }




}
