# AppRestarter

`quit_open.sh` を SwiftUI macOS アプリとして一般化したもの。

## ファイル構成

```
AppRestarter/
├── AppRestarterApp.swift   # @main エントリーポイント
├── ContentView.swift       # UI（SwiftUI）
└── AppRestarter.swift      # ロジック（NSWorkspace）
```

---

## Xcode でのセットアップ手順

### 1. プロジェクト作成

1. Xcode を開く → **Create New Project**
2. **macOS** タブ → **App** を選択 → Next
3. 設定：
   - Product Name: `AppRestarter`
   - Team: （開発者アカウント or None）
   - Organization Identifier: `com.yourname`（任意）
   - Interface: **SwiftUI**
   - Language: **Swift**
   - ✅ Include Tests は外してOK
4. 保存先を選んで **Create**

### 2. ファイルを追加

Xcode が自動生成した `ContentView.swift` と `<AppName>App.swift` を**このリポジトリのファイルで上書き**する。

方法A（上書き）：
- Xcode のファイルリストで `ContentView.swift` をクリック
- 全選択（⌘A）して内容を `ContentView.swift` の中身で置き換える
- 同様に `AppRestarterApp.swift` と既存の `*App.swift` を置き換える

方法B（追加）：
- Finder からファイルを Xcode のナビゲーターにドラッグ
- 「Copy items if needed」にチェック → Finish

`AppRestarter.swift` はデフォルトで存在しないので **File → New → File → Swift File** で追加して内容を貼り付ける。

### 3. Entitlements の設定（重要）

他のアプリを terminate するために **App Sandbox を無効化**する必要がある。

1. ナビゲーターでプロジェクトルート（青いアイコン）をクリック
2. Targets → `AppRestarter` → **Signing & Capabilities** タブ
3. **App Sandbox** の項目があれば ✕ で削除する
   - ない場合はそのままでOK（デフォルトで Sandbox 無効のプロジェクトもある）

> Sandbox が有効なままだと `NSWorkspace.runningApplications` で他アプリが見えなかったり、terminate が失敗する。

### 4. ビルドと実行

```
⌘R  （Run）
```

エラーが出た場合：
- `Signing` エラー → Signing & Capabilities → Team を "None" にして **Automatically manage signing** を ON
- `Cannot find type 'AppRestarter'` → ファイルの Target Membership を確認（ファイル選択 → File Inspector → Target Membership にチェック）

---

## 使い方

### テキストフィールドから再起動
1. 上部のフィールドにアプリ名を入力（例: `Brave Browser`）
2. **Restart** ボタンを押す or Return キー

### 登録リストから再起動
1. **＋追加** → アプリ名を入力 → 追加
2. 一覧の **Restart** ボタンをクリック
3. 登録はアプリ再起動後も保持される（UserDefaults）

---

## 注意

- アプリ名は `/Applications/<名前>.app` のフォルダ名と一致している必要がある
- `~/Applications/` も検索対象
- 起動中でないアプリは quit をスキップして open のみ実行される
- System フォルダ内のアプリへも検索対象を拡大済み
