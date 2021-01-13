class Cryptos {
  int id;
  String name;
  String symbol;
  Quote quote;

  Cryptos({this.id, this.name, this.symbol, this.quote});

  factory Cryptos.fromJson(Map<dynamic, dynamic> json) {
    return Cryptos(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      quote: Quote.fromJson(json["quote"]),
    );
  }
}

class Quote {
  Quote({
    this.usd,
  });

  Usd usd;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        usd: Usd.fromJson(json["USD"]),
      );
}

class Usd {
  Usd({
    this.price,
    this.percentChange24H,
  });

  double price;
  double percentChange24H;

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json["price"].toDouble(),
        percentChange24H: json["percent_change_24h"].toDouble(),
      );
}

class IndCrypto {
  int id;
  String name;
  String symbol;
  double price;
  double percentChange24H;

  IndCrypto(
      {this.id, this.name, this.symbol, this.price, this.percentChange24H});
}
