// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class CustomNetworkImage extends ImageProvider<CustomNetworkImage> {
//   final String url;
//   final Map<String, String>? headers;

//   const CustomNetworkImage(this.url, {this.headers});

//   @override
//   ImageStreamCompleter loadImage(
//       CustomNetworkImage key, ImageDecoderCallback decode) {
//     return MultiFrameImageStreamCompleter(
//       codec: _loadAsync(key),
//       scale: 1.0,
//       informationCollector: () sync* {
//         yield DiagnosticsProperty<ImageProvider>('Image provider', this);
//         yield DiagnosticsProperty<CustomNetworkImage>('Image key', key);
//       },
//     );
//   }

//   Future<Codec> _loadAsync(CustomNetworkImage key) async {
//     assert(key == this);

//     final Uri resolved = Uri.base.resolve(key.url);
//     final HttpClientRequest request = await HttpClient().getUrl(resolved);
//     headers?.forEach((String name, String value) {
//       request.headers.add(name, value);
//     });
//     final HttpClientResponse response = await request.close();
//     if (response.statusCode != HttpStatus.ok) {
//       throw Exception('Failed to load image: ${response.statusCode}');
//     }

//     final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
//     if (bytes.lengthInBytes == 0) {
//       throw Exception('NetworkImage is an empty file: $resolved');
//     }

//     return await PaintingBinding.instance.instantiateImageCodec(bytes);
//   }

//   @override
//   Future<CustomNetworkImage> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<CustomNetworkImage>(this);
//   }
// }