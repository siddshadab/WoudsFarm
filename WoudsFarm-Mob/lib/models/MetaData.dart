class Metadata {
  String mcreateddt;
  String mlastupdatedt;
  String mlastupdateby;
  String mgeologd;
  String mgeolatd;
  bool isDeleted;

  Metadata(
      {this.mcreateddt,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeologd,
        this.mgeolatd,
        this.isDeleted});

  Metadata.fromJson(Map<String, dynamic> json) {
    mcreateddt = json['mcreateddt'];
    mlastupdatedt = json['mlastupdatedt'];
    mlastupdateby = json['mlastupdateby'];
    mgeologd = json['mgeologd'];
    mgeolatd = json['mgeolatd'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcreateddt'] = this.mcreateddt;
    data['mlastupdatedt'] = this.mlastupdatedt;
    data['mlastupdateby'] = this.mlastupdateby;
    data['mgeologd'] = this.mgeologd;
    data['mgeolatd'] = this.mgeolatd;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}