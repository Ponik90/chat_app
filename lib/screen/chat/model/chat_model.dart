class ChatModel
{
  String? message,uid,docId,datetime;

  ChatModel({this.uid,this.datetime,this.message,this.docId});

  factory ChatModel.mapToModel(Map m1)
  {
    return ChatModel(
      datetime: m1['datetime'].toString(),
      message: m1['message'],
      uid: m1['uid']
    );
  }
}