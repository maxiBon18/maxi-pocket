import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

final class ProviderLogger extends ProviderObserver {
  final Logger _logger = getDI<Logger>();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _logger.t('Provider added: \n ${context.provider.runtimeType} \n Value: $value');
  }

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    _logger.t('Provider Fail: \n ${context.provider.runtimeType} \n Error: $error \n StackTrace: $stackTrace');
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    _logger.t(
      'Provider Update: \n ${context.provider.runtimeType} \n PreviousValue: $previousValue \n NewValue: $newValue',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _logger.t('Provider Disposed: \n ${context.provider.runtimeType}');
  }
}

void customDebugPrint(String message) {
  if (kDebugMode) {
    return debugPrint(message);
  }
}
