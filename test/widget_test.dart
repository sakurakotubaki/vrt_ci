import 'package:flutter/material.dart';
import 'package:golden_test/golden_test.dart';
import 'package:vrt_ci/dash_preview.dart';

void main() {
  goldenTestSupportedThemes = [Brightness.light];

  goldenTest(
    name: 'DashBefore',
    builder: (_) => const DashBeforeCard(),
  );

  goldenTest(
    name: 'DashRounded',
    builder: (_) => const DashRoundedCard(),
  );
}
