import 'package:flutter/foundation.dart';

extension Retry<T> on Future<T> Function() {
  Future<T> withRetries(int count) async {
    while (true) {
      if (kDebugMode) print('Retries left: $count'); 
      try {
        return await this();
      } catch (e) {
        if (count-- <= 0) {
          rethrow;
        }
      }
    }
  }
}
