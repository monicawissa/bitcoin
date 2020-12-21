import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'services/coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin/services/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  String btcCurrency = 'BTC';
  String ethCurrency = 'ETH';
  String ltcCurrency = 'LTC';

  String ans = '?';
  String ansETH = '?';
  String ansLTC = '?';
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void getData() async {
    dynamic data = await coinData.getCoinData(btcCurrency, selectedCurrency);
    dynamic data2 = await coinData.getCoinData(ethCurrency, selectedCurrency);
    dynamic data3 = await coinData.getCoinData(ltcCurrency, selectedCurrency);

    int dta = data['rate'].toInt();
    int dta2 = data2['rate'].toInt();
    int dta3 = data3['rate'].toInt();

    setState(() {
      ans = dta.toString();
      ansETH = dta2.toString();
      ansLTC = dta3.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          item(
              fromCurrency: btcCurrency,
              ans: ans,
              selectedCurrency: selectedCurrency),
          item(
              fromCurrency: ethCurrency,
              ans: ansETH,
              selectedCurrency: selectedCurrency),
          item(
              fromCurrency: ltcCurrency,
              ans: ansLTC,
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class item extends StatelessWidget {
  const item({
    Key key,
    @required this.fromCurrency,
    @required this.ans,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String fromCurrency;
  final String ans;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $fromCurrency = $ans $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
