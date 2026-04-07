# vrt_ci

Flutter を使った VRT (Visual Regression Testing) のサンプルプロジェクトです。  
ゴールデン画像を Git で管理し、外部ストレージなしで PR 間の UI 差分を検出します。

## 環境

| ツール    | バージョン |
|-----------|-----------|
| Flutter   | 3.41.5    |
| Dart      | 3.11.3    |
| FVM       | 使用中     |

FVM でバージョンを固定しています。

```bash
fvm use
flutter pub get
```

## VRT の仕組み

```
develop ブランチ
  └── test/goldens/**/*.png  ← ベースライン画像（Git 管理）

PR (test/vrt → develop)
  └── GitHub Actions が flutter test を実行
        ├── 成功: 画像差分なし → CI グリーン
        └── 失敗: 画像差分あり → test/failures/ に差分画像を生成
                                  → Actions の Artifacts からダウンロードして確認
```

## ゴールデン画像の初回生成手順

**必ず Linux 環境（または CI と同じ OS）で実行してください。**  
macOS と Linux でフォントレンダリングが異なるため、macOS で生成した画像は CI で失敗する場合があります。

### ローカル（Linux 環境 / Docker）

```bash
# ゴールデン画像を生成・更新する
flutter test --update-goldens

# 生成されたファイルを確認
ls test/goldens/
```

### Docker を使う場合（macOS 開発者向け）

```bash
docker run --rm -v $(pwd):/app cirrusci/flutter:3.41.5 \
  sh -c "cd /app && flutter pub get && flutter test --update-goldens"
```

### 生成後のコミット

```bash
git add test/goldens/
git commit -m "chore: update golden images"
git push
```

## VRT の実行（通常の CI フロー）

PR を develop ブランチへ作成すると GitHub Actions が自動実行されます。

```bash
# ローカルで確認する場合
flutter test
```

差分が出た場合は `test/failures/` に以下が保存されます。

```
test/failures/
  └── goldens/en/light/
        ├── HomePage_isolatedDiff.png   ← 変化した箇所のみ
        ├── HomePage_masked.png         ← 変化前
        └── HomePage_testImage.png      ← 変化後
```

## UI を変更したとき

1. UI を変更してローカルで動作確認
2. `flutter test --update-goldens` でゴールデン画像を更新
3. 差分画像を確認して意図した変更かチェック
4. `test/goldens/` をコミットして PR を作成
