import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bundle_resources_loader_platform_interface.dart';

/// An implementation of [BundleResourcesLoaderPlatform] that uses method channels.
class MethodChannelBundleResourcesLoader extends BundleResourcesLoaderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bundle_resources_loader');

  @override
  Future<List<String>> searchResources({
    String? fileName,
    String? fileExt,
  }) async {
    return await methodChannel.invokeListMethod<String>('searchResources', {
          'extension': fileExt,
          'filename': fileName,
        }) ??
        <String>[];
  }
}
