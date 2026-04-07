import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:vrt_ci/main.dart';

void main() {
  // ライトモードのみテスト（CIでの安定性のため）
  goldenTestSupportedThemes = [Brightness.light];

  goldenTest(
    name: 'HomePage',
    builder: (_) => const HomePage(),
  );
}
