import 'package:rxdart/rxdart.dart';

class MessageHandler {
  factory MessageHandler() => _instance;
  MessageHandler._internal();

  static final MessageHandler _instance = MessageHandler._internal();

  final _messageStream = BehaviorSubject<MessageData>();

  Stream<MessageData> get message => _messageStream.stream;

  void addError(MessageData message) {
    _messageStream.add(message);
  }
}

class MessageData {
  MessageData({required this.title, required this.message, this.isError});

  final String title;
  final String message;
  final bool? isError;
}
