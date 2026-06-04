# Xcodeでのセットアップ手順
## For the physical operator (神様向け)

---

## 開く方法

```bash
open TERRA/Package.swift
```

Xcodeが自動的にパッケージを認識し、ワークスペースを生成します。

---

## ビルド前の必須設定（Xcode UI内で行う）

### 1. Signing & Capabilities

`TERRA` ターゲット → **Signing & Capabilities**

- [ ] **Team**: Apple Developerアカウントのチームを選択
- [ ] **Bundle Identifier**: `world.terraapp.TERRA`
  （App Store Connect で事前に登録が必要）
- [ ] **Entitlements file**: `Sources/TERRA/Resources/TERRA.entitlements` を指定
- [ ] **App Sandbox**: ON（必須）
- [ ] **Hardened Runtime**: ON（公証に必須）

### 2. Build Settings から xcconfig を適用

`TERRA` ターゲット → **Build Settings** → + ボタン →
"Add Build Configuration File..." → `TERRA.xcconfig` を選択

### 3. App Icon

`Assets.xcassets/AppIcon.appiconset/` に以下のPNGを配置：
（サイズ一覧は `Resources/AppIcon.md` 参照）

```
AppIcon-16.png    (16×16)
AppIcon-32.png    (32×32)
AppIcon-64.png    (64×64)
AppIcon-128.png   (128×128)
AppIcon-256.png   (256×256)
AppIcon-512.png   (512×512)
AppIcon-1024.png  (1024×1024)
```

→ **物理ブロッカー**: PNG画像ファイルの作成（後述）

### 4. Info.plist の確認

`Sources/TERRA/Resources/Info.plist` は既に設定済み。
Xcode が自動検出できない場合：
**Build Settings** → **Info.plist File** に手動パスを入力。

### 5. Localization 追加

**Project** → **Info** → **Localizations** → `+` → **Japanese** を追加。
`ja.lproj/Localizable.strings` は既に存在。

---

## Debug ビルド

```
Cmd + R
```

ターゲット: `My Mac`

---

## TestFlight / App Store 提出フロー

1. Archive: `Product → Archive`
2. Validate App（Xcode Organizer内）
3. Distribute App → App Store Connect
4. TestFlight で内部テスト → 外部テスト
5. App Store Review 提出

---

## 物理ブロッカーリスト（後述セクション参照）

`PHYSICAL_BLOCKERS.md` を参照。
