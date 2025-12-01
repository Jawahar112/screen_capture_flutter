import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

class NavigatorWeb {
  /// Request microphone / camera
  static Future<web.MediaStream> getUserMedia(
    Map<String, dynamic> constraints,
  ) async {
    try {
      final constraints = web.MediaStreamConstraints();

      final stream = await web.window.navigator.mediaDevices
          .getUserMedia(constraints)
          .toDart;

      return stream;
    } catch (e) {
      throw Exception("getUserMedia failed: $e");
    }
  }

  /// Request screen share
  static Future<web.MediaStream> getDisplayMedia(
    Map<String, dynamic> constraints,
  ) async {
    try {
      final constraints = web.DisplayMediaStreamOptions();

      final stream = await web.window.navigator.mediaDevices
          .getDisplayMedia(constraints)
          .toDart;

      return stream;
    } catch (e) {
      throw Exception("getDisplayMedia failed: $e");
    }
  }

  /// List all media devices
static Future<List<Map<String, String>>> getSources() async {
  try {
    // 1. Await the JS promise
    final jsDevicesPromise = web.window.navigator.mediaDevices.enumerateDevices();
    final jsDevices = await jsDevicesPromise.toDart as List<Object?>;

    // 2. Convert to Dart List and iterate
    final List<Map<String, String>> list = [];

    for (final device in jsDevices) {
      final d = device as web.MediaDeviceInfo;
      list.add({
        'deviceId': d.deviceId ,
        'groupId': d.groupId ,
        'kind': d.kind ,
        'label': d.label,
      });
    }

    return list;
  } catch (e) {
    throw Exception("enumerateDevices failed: $e");
  }
}

}
