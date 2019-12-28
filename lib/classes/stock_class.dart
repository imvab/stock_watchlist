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

    Map<String, dynamic> toDb(){
      var map = Map<String, dynamic>();
      map["symbol"] = symbol;
      map["name"] = nameOfCompany;
      map["series"] = series;
      map["date_listing"] = dateOfListing;
      map["paid_value"] = paidUpValue;
      map["mkt_lot"] = marketLot;
      map["isin_num"] = isinNumber;
      map["face_value"] = faceValue;
      return map;
    }



    factory Stock.fromDb(Map<String, dynamic> map) => Stock(
      symbol: map["symbol"],
      nameOfCompany: map["name"],
      series: map["series"],
      dateOfListing: map["date_listing"],
      paidUpValue: map["paid_value"],
      marketLot: map["mkt_lot"],
      isinNumber: map["isin_num"],
      faceValue: map["face_value"],
    );
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