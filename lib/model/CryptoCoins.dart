class CryptoCoins {
  double price;
  String name;
  String code;
  String image;
  String percen;

  CryptoCoins({this.price, this.name, this.image, this.percen, this.code});
}

List<CryptoCoins> cryptoCoins = [
  CryptoCoins(
      name: "Bitcoin",
      code: "BTC",
      price: 9537.64145,
      image: "assets/crypto_icons/btc.png",
      percen: "-16.5%"),
  CryptoCoins(
      name: "Basic Attention Token",
      code: "BAT",
      price: 0.25467,
      image: "assets/crypto_icons/bat.png",
      percen: "8.6%"),
  CryptoCoins(
      name: "Bitcoin Cash",
      code: "BCH",
      price: 183.23546,
      image: "assets/crypto_icons/bch.png",
      percen: "1.4%"),
  CryptoCoins(
      name: "Dash",
      code: "DASH",
      price: 63.45245,
      image: "assets/crypto_icons/dash.png",
      percen: "2.6%"),
  CryptoCoins(
      name: "Ether",
      code: "ETH",
      price: 312.35768,
      image: "assets/crypto_icons/eth.png",
      percen: "3.5%"),
  CryptoCoins(
      name: "Litecoin",
      code: "LTC",
      price: 35.82544,
      image: "assets/crypto_icons/ltc.png",
      percen: "-15.4%"),
  CryptoCoins(
      name: "Neo",
      code: "NEO",
      price: 12.54648,
      image: "assets/crypto_icons/neo.png",
      percen: "-8.9%"),
  CryptoCoins(
      name: "Tron",
      code: "TRX",
      price: 0.02546,
      image: "assets/crypto_icons/trx.png",
      percen: "26.7%"),
];
