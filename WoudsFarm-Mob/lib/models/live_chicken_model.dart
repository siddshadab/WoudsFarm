import 'package:wouds_farm/models/MetaData.dart';

class LiveChickenModel {
  String type;
  double weight;
  int serverWeight;
  String mobileNo;
  //Add below in Single Table Later
  double farmerQuote;
  double ourQuote;
  String inQueue;
  double finalAmount;
  bool isActive;
  String quoterMobileNo;
  String address;
  DateTime orderDate;
  bool isOrderFinalized;





  LiveChickenModel( {
    this.serverWeight,
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

  @override
  String toString() {
    return 'LiveChickenModel{type: $type, weight: $weight, mobileNo: $mobileNo, farmerQuote: $farmerQuote, ourQuote: $ourQuote, inQueue: $inQueue, finalAmount: $finalAmount, isActive: $isActive, quoterMobileNo: $quoterMobileNo, address: $address}';
  }

  LiveChickenModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    serverWeight = json['weight'];
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

class LiveChickenModelFromServer {

  String id;
  String mobileNo;
  List<LiveChickenModel> data;
  Metadata metadata;

  LiveChickenModelFromServer( {
    this.mobileNo,
    this.id,
    this.data,
    this.metadata
  });

  @override
  String toString() {
    return 'LiveChickenModelFromServer{id: $id, mobileNo: $mobileNo, data: $data}';
  }

  LiveChickenModelFromServer.fromServerJson(Map<String, dynamic> json) {
    id = json['_id'] != null ?json['_id'] : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    mobileNo = json['mobileNo'];
    if (json['data'] != null) {
      data = new List<LiveChickenModel>();
      json['data'].forEach((v) {
        data.add(new LiveChickenModel.fromJson(v));
      });
    }

  }
}