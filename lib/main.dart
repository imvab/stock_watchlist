import 'package:flutter/material.dart';
import 'package:stock_watchlist/screens/stock_list_updated.dart';


void main() => runApp(Watchlist());



class Watchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Watchlist",
      home: StockList(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
