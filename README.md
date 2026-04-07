# vrt_ci

Flutter の VRT（ゴールデンテスト）サンプルです。  
ゴールデン画像を Git で管理し、外部ストレージなしで PR の UI 差分を検出します。

**スクリーンショット例:** `HomePage`（アプリ画面）、**変更前（矩形）**の `DashBefore`、**丸抜き（`ClipOval`）**の `DashRounded` を `test/goldens/` に保存します。

## 環境

| 項目    | バージョン |
|---------|------------|
| Flutter | 3.41.5     |
| Dart    | 3.11.3     |

FVM を使う場合:

```bash
fvm use
flutter pub get
```

## ゴールデン画像

| ファイル | 内容 |
|----------|------|
| `test/goldens/en/light/HomePage.png` | [HomePage](lib/main.dart)（AppBar + 丸抜きカード） |
| `test/goldens/en/light/DashBefore.png` | 角丸なし矩形（[DashBeforeCard](lib/dash_preview.dart)） |
| `test/goldens/en/light/DashRounded.png` | `ClipOval` による丸抜き（[DashRoundedCard](lib/dash_preview.dart)） |

PR の **Files changed** で PNG の画像 diff を確認できます。CI 成功時は Actions の **Artifacts** に `golden-baselines-*` として同じ画像が添付されます。

## VRT の仕組み

```
develop ブランチ
  └── test/goldens/**/*.png  ← ベースライン（Git 管理）

PR → develop
  └── GitHub Actions が flutter test を実行
        ├── 成功: 差分なし → CI グリーン
        └── 失敗: test/failures/ に差分画像 → Artifacts で確認
```

## ゴールデン更新（CI と同じ Linux / amd64）

**必ず CI と同じ環境で生成してください。** macOS 単体の `--update-goldens` では Ubuntu CI とピクセルがずれることがあります。

### Docker（macOS 向け）

```bash
docker run --rm --platform linux/amd64 -v "$(pwd)":/app -w /app \
  ghcr.io/cirruslabs/flutter:3.41.5 \
  bash -c "flutter pub get && flutter test --update-goldens"
```

### 生成後のコミット

```bash
git add test/goldens/
git commit -m "chore: update golden images"
git push
```

## ローカルでテスト

```bash
flutter test
```

差分が出た場合は `test/failures/` に各テスト名に対応した差分 PNG が出力されます。

## UI を変更したとき

1. 変更を確認
2. 上記 Docker で `flutter test --update-goldens`
3. 差分を確認してから `test/goldens/` をコミット
