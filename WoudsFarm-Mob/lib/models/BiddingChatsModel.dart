import 'package:wouds_farm/models/MetaData.dart';

class  BiddingChatsModel {

  String email ;
   String sender;
   String reciever;
  Metadata metadata;
   String message;
   bool isMe;


  BiddingChatsModel({
    this.email,
      this.sender,
      this.reciever,
      this.metadata,
      this.message,
      this.isMe});



  BiddingChatsModel.fromServerJson(Map<String, dynamic> json) {
    email= json['email'] != null ?json['email'] : null;
    sender = json['sender'] != null ?json['sender'] : null;
    reciever = json['reciever'] != null ?json['reciever'] : null;
    message = json['message'] != null ?json['message'] : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;
    data['message'] = this.message;
    return data;
  }


}



