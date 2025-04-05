import 'dart:async';

import 'package:api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/utils/utils.dart';

class ErrorListener extends StatefulWidget {
  const ErrorListener({super.key, required this.child});
  final Widget child;

  @override
  State<ErrorListener> createState() => _ErrorListenerState();
}

class _ErrorListenerState extends State<ErrorListener> {
  late final StreamSubscription<MessageData> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = MessageHandler().message.listen((messageData) {
      Utils.showSnackBar(
        title: messageData.title,
        message: messageData.message,
      );
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
