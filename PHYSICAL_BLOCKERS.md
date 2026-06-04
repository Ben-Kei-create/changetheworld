# 物理ブロッカーリスト
## 神様（物理的な操作者）へのリクエスト

作成日: 2026-06-04 | スプリント3

---

## ⛔ ブロッカー（これがないと次に進めないもの）

現時点では**なし**。
以下はすべてスキップして進行可能。ただし提出前に必要。

---

## ⚠️ 提出前に必要（スキップ可 — 最後に対応）

### 1. アプリアイコン PNG ファイル
**何が必要：**
- `AppIcon-16.png` から `AppIcon-1024.png` まで（7サイズ）
- デザイン仕様は `TERRA/Sources/TERRA/Resources/AppIcon.md` 参照
- 内容：深宇宙背景に発光する地球儀（シンプル・ミニマル）

**なぜ物理作業が必要か：**
このLinux環境ではPNG画像を生成・描画できない。
Figma / Sketch / Photoshop / Pixelmator でデザイン後、
`Assets.xcassets/AppIcon.appiconset/` に配置。

**スキップ影響：** ビルド・実行は可能。App Store提出時に必須。

---

### 2. Xcode でのコード署名設定
**何が必要：**
- Apple Developer アカウント（有料: $99/年）
- Xcode 上で Team ID と Bundle ID を紐付け
- `XCODE_SETUP.md` の「Signing & Capabilities」セクションを参照

**スキップ影響：** ローカルビルドは可能（署名なしで実行）。
TestFlight・App Store提出には必須。

---

### 3. BGM / 効果音 ファイル
**何が必要：**
- `bgm_main_menu.mp3`, `bgm_amara.mp3`, ... （8トラック）
- `sfx_tap.aiff`, `sfx_choice.aiff`, ... （6種）
- `TERRA/Sources/TERRA/App/SoundManager.swift` のファイル名一覧参照

**なぜ物理作業が必要か：**
音楽・効果音ファイルは作曲家またはDAWソフトで制作。
代替案：ロイヤリティフリー音源（FreeSound, Pixabay Audio）で仮置き可能。

**スキップ影響：** ゲームは無音で動作する（SoundManagerがフォールバック済み）。
体験品質が下がるが、機能には影響なし。

---

### 4. App Store Connect 登録
**何が必要：**
- Apple Developer Programへの登録（$99/年）
- App Store Connect でアプリページ作成
- Bundle ID `world.terraapp.TERRA` の登録
- ドメイン `terraapp.world` の取得（Privacy Policy URL用）

**スキップ影響：** 開発・テストには影響なし。提出時に必須。

---

## ✅ スキップ不要（開発チームが解決済み）

| 項目 | 状態 |
|------|------|
| Swift ソースコード（全View/Model/Engine） | ✅ 完了 |
| Package.swift（SPMビルド定義） | ✅ 完了 |
| entitlements ファイル | ✅ 完了 |
| xcconfig（ビルド設定） | ✅ 完了 |
| Assets.xcassets 構造（JSON） | ✅ 完了（画像ファイル待ち） |
| Info.plist | ✅ 完了 |
| PrivacyInfo.xcprivacy | ✅ 完了 |
| 日英ローカライズ文字列 | ✅ 完了 |
| 全6キャラクター × 3シーン ストーリー | ✅ 完了 |
| デザインシステム（DesignTokens） | ✅ 完了 |
| サウンドアーキテクチャ（実ファイル待ち） | ✅ 完了 |
| App Store戦略書 | ✅ 完了 |
| 法務チェックリスト | ✅ 完了 |
| Xcodeセットアップ手順書 | ✅ 完了 |

---

*更新者: Kai Nakamura（開発リード） / スプリント3*
