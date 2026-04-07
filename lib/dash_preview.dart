import 'package:flutter/material.dart';

const String kDashAsset = 'assets/images/Dash.png';

/// 角丸なしの矩形表示（変更前・ベースライン用）
class DashBeforeCard extends StatelessWidget {
  const DashBeforeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      color: Colors.grey[200],
      child: Image.asset(kDashAsset),
    );
  }
}

/// 円形クリップ（丸抜き）
class DashRoundedCard extends StatelessWidget {
  const DashRoundedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 150,
        height: 150,
        color: Colors.grey[200],
        child: Image.asset(kDashAsset),
      ),
    );
  }
}
