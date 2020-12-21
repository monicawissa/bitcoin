//TODO: Add your imports here.
import 'package:bitcoin/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
//https://rest.coinapi.io/v1/exchangerate/BTC/USD
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BD4724E0-76C0-4AB9-8E46-1956D246AB82';

class CoinData {
  //TODO: Create your getCoinData() method here.
  Future<dynamic> getCoinData(String from, String to) async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinAPIURL/$from/$to?apiKey=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
