import 'package:flutter/material.dart';
import 'package:golden_test/golden_test.dart';
import 'package:vrt_ci/dash_preview.dart';
import 'package:vrt_ci/main.dart';

void main() {
  goldenTestSupportedThemes = [Brightness.light];

  goldenTest(
    name: 'HomePage',
    builder: (_) => const HomePage(),
  );

  goldenTest(
    name: 'DashBefore',
    builder: (_) => const DashBeforeCard(),
  );

  goldenTest(
    name: 'DashRounded',
    builder: (_) => const DashRoundedCard(),
  );
}
