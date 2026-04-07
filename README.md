# vrt_ci

Flutter の VRT（ゴールデンテスト）サンプルです。  
**変更前（矩形）**と**丸抜き（円形クリップ）**の2枚を `test/goldens/` に保存し、PR の差分で確認できます。

## 環境

| 項目    | バージョン |
|---------|------------|
| Flutter | 3.41.5     |

## ゴールデン画像

| ファイル | 内容 |
|----------|------|
| `test/goldens/en/light/DashBefore.png` | 角丸なしの矩形表示（[DashBeforeCard](lib/dash_preview.dart)） |
| `test/goldens/en/light/DashRounded.png` | `ClipOval` による丸抜き（[DashRoundedCard](lib/dash_preview.dart)） |

PR の **Files changed** で PNG の画像 diff を確認できます。CI 成功時は Actions の **Artifacts** に `golden-baselines-*` として同じ画像が添付されます。

## ゴールデン更新（CI と同じ Linux / amd64）

macOS 単体で `--update-goldens` すると CI（Ubuntu）とピクセルがずれることがあります。

```bash
docker run --rm --platform linux/amd64 -v "$(pwd)":/app -w /app \
  ghcr.io/cirruslabs/flutter:3.41.5 \
  bash -c "flutter pub get && flutter test --update-goldens"
```

その後 `test/goldens/` をコミットしてください。
