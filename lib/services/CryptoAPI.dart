import 'package:flutterCrypto/import/Imports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoAPI {
  /*This function will load all the variables to the page "MarketView" */
  Future<List> updateMarket() async {
    String requestType =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=" +
            Keys().coinMarketCapKey;
    String limit = "&limit=10";
    String type = "&cryptocurrency_type=";

    String cryptoUrl = requestType + limit + type + "coins";
    String tokenUrl = requestType + limit + type + "tokens";
    /*Calling the API url */
    http.Response coinResponse = await http.get(cryptoUrl);
    http.Response tokenResponse = await http.get(tokenUrl);
    /*If the response is 200 (success) then the response will be decoded */

    if (coinResponse.statusCode == 200 && tokenResponse.statusCode == 200) {
      Map<String, dynamic> map = await jsonDecode(coinResponse.body);

      List body = map['data'];

      List<Cryptos> cryptos = body
          .map(
            (item) => Cryptos.fromJson(item),
          )
          .toList();

      Map<String, dynamic> mapToken = await jsonDecode(tokenResponse.body);

      List bodyToken = mapToken['data'];
      List<Cryptos> tokens = bodyToken
          .map(
            (item) => Cryptos.fromJson(item),
          )
          .toList();

      return [cryptos, tokens];
    } else {
      print("Error Requesting API");
      return null;
    }
  }

  Future<IndCrypto> individualCoin(int coinId) async {
    String cryptoUrl =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?CMC_PRO_API_KEY=" +
            Keys().coinMarketCapKey +
            "&id=" +
            coinId.toString();
    /*Calling the API url */

    http.Response coinResponse = await http.get(cryptoUrl);
    /*If the response is 200 (success) then the response will be decoded */

    if (coinResponse.statusCode == 200) {
      IndCrypto crypto = IndCrypto();
      Map<String, dynamic> mapCoin = await jsonDecode(coinResponse.body);
      var bodyCrypto = mapCoin['data']['${coinId.toString()}'];
      crypto.id = bodyCrypto['id'];

      crypto.name = bodyCrypto['name'];
      crypto.symbol = bodyCrypto['symbol'];
      crypto.price = bodyCrypto['quote']['USD']['price'];
      crypto.percentChange24H =
          bodyCrypto['quote']['USD']['percent_change_24h'];

      return crypto;
    } else {
      print("Error Requesting API");
      return null;
    }
  }

  Future<List<Cryptos>> buyList() async {
    String requestType =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=" +
            Keys().coinMarketCapKey;
    String limit = "&limit=10";
    String type = "&cryptocurrency_type=";

    String cryptoUrl = requestType + limit + type + "coins";
    /*Calling the API url */
    http.Response coinResponse = await http.get(cryptoUrl);
    /*If the response is 200 (success) then the response will be decoded */

    if (coinResponse.statusCode == 200) {
      Map<String, dynamic> map = await jsonDecode(coinResponse.body);

      List body = map['data'];

      List<Cryptos> cryptos = body
          .map(
            (item) => Cryptos.fromJson(item),
          )
          .toList();

      return cryptos;
    } else {
      print("Error Requesting API");
      return null;
    }
  }

  Future<List<Cryptos>> rank() async {
    String requestType =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=" +
            Keys().coinMarketCapKey;
    String sort = "&sort=volume_7d";
    String limit = "&limit=10";
    String cryptoUrl = requestType + limit + sort;

    /*Calling the API url */
    http.Response coinResponse = await http.get(cryptoUrl);

    /*If the response is 200 (success) then the response will be decoded */

    if (coinResponse.statusCode == 200) {
      Map<String, dynamic> map = await jsonDecode(coinResponse.body);

      List body = map['data'];

      List<Cryptos> cryptos = body
          .map(
            (item) => Cryptos.fromJson(item),
          )
          .toList();

      return cryptos;
    } else {
      print("Error Requesting API");
      return null;
    }
  }
}
