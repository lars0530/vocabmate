import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'version_provider.g.dart';

@Riverpod(dependencies: [])
String version(Ref ref) {
  return const String.fromEnvironment(
    'RELEASE_DATE_VERSION',
    defaultValue: 'Nov 21 2024 ABC',
  );
}
