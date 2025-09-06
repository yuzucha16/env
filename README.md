# Windows setup

## Install

- ネットワークを使わないでログイン処理を進める
    - Shift + F10
    - oobe\bypassnro.cmd

- Windows Updateを行う

- Assistant dellをインストールする

- タスクバー設定を行う
	- 左に寄せる，アイテムを減らす
	
- コントロールパネル
	- カンマ/ピリオド，半角スペース，IME:履歴オフ，マウスサイズ
	- エクスプローラー
	  - 最近使用したファイルを表示する：チェック外す
	  - 頻繁に使用されるフォルダーを表示する：チェック外す
	  - 拡張子，隠しファイル
	- win + Rの履歴登録
	  - control
	  - sysdm.cpl
	  - devmgmt.msc
	  - shell:startup

## 手順

- github:: yuzucha16/env からzipをダウンロードする

- dotfiles/_script/w0 から w2(管理者権限)までを実行する

- ghq get yuzucha16/env でオリジナルをcloneする

  ```shell
  git fetch
  git switch 202509
  ```

- Power shellスクリプトの実行ポリシーを変更する

  - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
  - Set-ExecutionPolicy RemoteSigned -Scope Process -Force
  - Get-ExecutionPolicy -List

- scoopで入らないアプリをインストールする

- downloadしたyuzucha16/envを削除する

- フォントをインストールする

- ghq(clone)したリポジトリのdotfiles/_script/w2(管理者権限)から再開する

- wslをセットアップする

  ```bash
  sudo chmod +x ./l0_setup.sh
  sudo chmod +x ./l0a_apt_install.sh
  sudo chmod +x ./l1_copy_dotfiles.sh
  sudo chmod +x ./l2_init_workspace.sh
  ./l0_setup.sh
  ./l0a_apt_install.sh
  unlink ~/.bash_logout
  unlink ~/.bashrc
  unlink ~/.profile
  ./l1_copy_dotfiles.sh
  ./l2_init_workspace.sh
  ```

- `shell:startup` にショートカットをおく

## アプリ

- xyplorer - portable package
  - [XYplorer - Download](https://www.xyplorer.com/download.php?bit=32)

## git

- config
  ```shell
  git config --global user.name "kazend"
  git config --global user.email "kazuyuki.endou7@gmail.com"
  git config --global core.autocrlf false
  ```
  
## 開発者向け

- シンボリックリンクが張れる

- `開発者向け設定` をオンにする．
  - `Windows`ボタンから`開発者向け`と検索する

## コマンドプロンプト

- 簡易編集モード

