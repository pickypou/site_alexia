import 'dart:js_interop';

@JS('URL.createObjectURL')
external String createObjectUrl(Blob blob);

@JS('Blob')
external Blob createBlob(JSArray parts, BlobPropertyBag options);

@JS()
@anonymous
@staticInterop
class Blob {}

extension BlobExtension on Blob {}

@JS()
@anonymous
@staticInterop
class BlobPropertyBag {
  external factory BlobPropertyBag({String type});
}

extension BlobPropertyBagExtension on BlobPropertyBag {
  external String get type;
}

@JS('window.open')
external void open(String url, String target);
