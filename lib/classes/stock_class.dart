import 'dart:convert';

Stock stockFromJson(String str) => Stock.fromJson(json.decode(str));

String stockToJson(Stock data) => json.encode(data.toJson());

class Stock {
    String symbol;
    String nameOfCompany;
    String series;
    String dateOfListing;
    int paidUpValue;
    int marketLot;
    String isinNumber;
    int faceValue;

    Stock({
        this.symbol,
        this.nameOfCompany,
        this.series,
        this.dateOfListing,
        this.paidUpValue,
        this.marketLot,
        this.isinNumber,
        this.faceValue,
    });

    factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        symbol: json["SYMBOL"],
        nameOfCompany: json["NAME OF COMPANY"],
        series: json["SERIES"],
        dateOfListing: json["DATE OF LISTING"],
        paidUpValue: json["PAID UP VALUE"],
        marketLot: json["MARKET LOT"],
        isinNumber: json["ISIN NUMBER"],
        faceValue: json["FACE VALUE"],
    );

    get length => null;

    Map<String, dynamic> toJson() => {
        "SYMBOL": symbol,
        "NAME OF COMPANY": nameOfCompany,
        "SERIES": series,
        "DATE OF LISTING": dateOfListing,
        "PAID UP VALUE": paidUpValue,
        "MARKET LOT": marketLot,
        "ISIN NUMBER": isinNumber,
        "FACE VALUE": faceValue,
    };
}


class StockBundle{
    final List<Stock> stocks;
    StockBundle({this.stocks});

    factory StockBundle.fromJson(List<dynamic> parsedJson){
      List<Stock> stocks = new List<Stock>();

      stocks = parsedJson.map((i) => Stock.fromJson(i)).toList();

      return new StockBundle(stocks: stocks);
    }
}