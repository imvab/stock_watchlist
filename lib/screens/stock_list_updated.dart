import 'package:flutter/material.dart';
// import 'package:stock_watchlist/screens/add_stock.dart';
import 'package:stock_watchlist/screens/web_view.dart';
import 'package:stock_watchlist/classes/stock_class.dart';
import 'package:stock_watchlist/models/db_helper.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

List<Stock> favs = [];
final db = StockDataBase();

void addStockToDb(Stock stock) async {
  await db.addStock(stock);
  //setupList();
}


Future<String> loadStockAsset() async {
  return await rootBundle.loadString('assets/stocks.json');
}

Future<List<Stock>> loadStocks() async {
  String jsonString = await loadStockAsset();
  final jsonResponse = json.decode(jsonString);
  StockBundle s = StockBundle.fromJson(jsonResponse);
  return s.stocks;
}


class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  void setupList() async {
    var stocks = await db.fetchAll();
    setState(() {
      favs = stocks;
    });
  } 

  @override
  void initState(){
    super.initState();
    setupList();
  }

  List<Widget> StackElements(BuildContext context){
    return <Widget>[
      AppBar(
        backgroundColor: Colors.black,
      ),
      Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
            ),
            color: Colors.black
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Stocks",
                  style: new TextStyle(
                    fontFamily: 'Avenir', 
                    fontWeight: FontWeight.bold, 
                    color: Colors.grey, 
                    fontSize: 50
                  )
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 60,
          margin: EdgeInsets.only(
            top: 170,
            left: MediaQuery.of(context).size.width * 0.5 - 30
          ),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch()
              );
            },
            backgroundColor: Colors.red,
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: StackElements(context)),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: favs.length,
              itemBuilder: (context, index){
                return FlatButton(
                  child: ListTile(
                    title: Center(
                      child: Text( favs[index].nameOfCompany.length > 30 ? favs[index].symbol : 
                        favs[index].nameOfCompany,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 20
                        ),
                      )
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new WebPageView(stockName: favs[index].symbol),
                      )
                    );
                  },
                );
              },
            )
          )
        ],
      )
    );   
  }
}



class DataSearch extends SearchDelegate<String>{
  
  Future<List<Stock>> items = loadStocks();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new FutureBuilder<List<Stock>>(
      future: loadStocks(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              if(query.length > 3 
                && snapshot.data[index].nameOfCompany.toLowerCase().startsWith(query.toLowerCase())){
                return FlatButton(
                  child: new ListTile(
                    title: Text(snapshot.data[index].nameOfCompany),
                    leading: Icon(Icons.location_city),
                  ),
                  onPressed: () {
                    favs.add(snapshot.data[index]);
                    addStockToDb(snapshot.data[index]);
                    close(context, null);
                  },
                );
              }else{
                return Column();
              }
            },
          );
        }else if(snapshot.hasError){
          return new Text("Snapshot Error");
        }else{
          return Center(child: Text("Loading"));
        }
      },
    );
  }
}