class LiveChickenModel {
  String type;
  double weight;
  String mobileNo;
  //Add below in Single Table Later
  double farmerQuote;
  double ourQuote;
  String inQueue;
  double finalAmount;
  bool isActive;
  String quoterMobileNo;
  String address;

  LiveChickenModel( {
    this.type,
    this.weight,
    this.mobileNo,
    this.farmerQuote,
    this.ourQuote,
    this.finalAmount,
    this.isActive,
    this.quoterMobileNo,
    this.address,
    this.inQueue,
  });

  LiveChickenModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    weight = json['weight'];
    mobileNo = json['mobileNo'];
    farmerQuote = json['farmerQuote'];
    ourQuote = json['ourQuote'];
    finalAmount = json['finalAmount'];
    isActive = json['isActive'];
    quoterMobileNo = json['quoterMobileNo'];
    address = json['address'];
    inQueue=json['inQueue'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['weight'] = this.weight;
    data['mobileNo'] = this.mobileNo;
    data['farmerQuote'] = this.farmerQuote;
    data['ourQuote'] = this.ourQuote;
    data['finalAmount'] = this.finalAmount;
    data['isActive'] = this.isActive;
    data['quoterMobileNo'] = this.quoterMobileNo;
    data['address'] = this.address;
    data['inQueue'] = this.inQueue;
    return data;
  }
}