import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bundle_resources_loader_method_channel.dart';

abstract class BundleResourcesLoaderPlatform extends PlatformInterface {
  /// Constructs a BundleResourcesLoaderPlatform.
  BundleResourcesLoaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static BundleResourcesLoaderPlatform _instance =
      MethodChannelBundleResourcesLoader();

  /// The default instance of [BundleResourcesLoaderPlatform] to use.
  ///
  /// Defaults to [MethodChannelBundleResourcesLoader].
  static BundleResourcesLoaderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BundleResourcesLoaderPlatform] when
  /// they register themselves.
  static set instance(BundleResourcesLoaderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<String>> searchResources({String? fileName, String? fileExt}) {
    throw UnimplementedError('searchResources() has not been implemented.');
  }
}
