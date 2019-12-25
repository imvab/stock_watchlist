class Stock {
  String sYMBOL;
  String nAMEOFCOMPANY;
  String sERIES;
  String dATEOFLISTING;
  int pAIDUPVALUE;
  int mARKETLOT;
  String iSINNUMBER;
  int fACEVALUE;

  Stock(
      {this.sYMBOL,
      this.nAMEOFCOMPANY,
      this.sERIES,
      this.dATEOFLISTING,
      this.pAIDUPVALUE,
      this.mARKETLOT,
      this.iSINNUMBER,
      this.fACEVALUE});

  Stock.fromJson(Map<String, dynamic> json) {
    sYMBOL = json['SYMBOL'];
    nAMEOFCOMPANY = json['NAME OF COMPANY'];
    sERIES = json['SERIES'];
    dATEOFLISTING = json['DATE OF LISTING'];
    pAIDUPVALUE = json['PAID UP VALUE'];
    mARKETLOT = json['MARKET LOT'];
    iSINNUMBER = json['ISIN NUMBER'];
    fACEVALUE = json['FACE VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SYMBOL'] = this.sYMBOL;
    data['NAME OF COMPANY'] = this.nAMEOFCOMPANY;
    data['SERIES'] = this.sERIES;
    data['DATE OF LISTING'] = this.dATEOFLISTING;
    data['PAID UP VALUE'] = this.pAIDUPVALUE;
    data['MARKET LOT'] = this.mARKETLOT;
    data['ISIN NUMBER'] = this.iSINNUMBER;
    data['FACE VALUE'] = this.fACEVALUE;
    return data;
  }
}