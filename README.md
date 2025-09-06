# Windows setup

## Install

- ネットワークを使わないでログイン処理を進める
    - Shift + F10
    - oobe\bypassnro.cmd

- Windows Updateを行う

- Assistant dellをインストールする

- タスクバー設定を行う
	- 左に寄せる，隠す，アイテムを減らす
	
- コントロールパネル
	- カンマ/ピリオド，半角スペース，IME:履歴オフ，マウスサイズ
	- win + Rの履歴登録
		- control
		- sysdm.cpl
		- devmgmt.msc
		- shell:startup

## 手順

- github:: yuzucha16/env からzipをダウンロードする

- dotfiles/_script/w0 から w2(管理者権限)までを実行する

- ghq get yuzucha16/env でオリジナルをcloneする

- Power shellスクリプトの実行ポリシーを変更する

  - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
  - Set-ExecutionPolicy RemoteSigned -Scope Process -Force
  - Get-ExecutionPolicy -List

- downloadしたyuzucha16/envを削除する

- scoopで入らないアプリをインストールする

- cloneしたリポジトリのdotfiles/_script/w2(管理者権限)から再開する

- wslをセットアップする

  ```bash
  sudo chmod +x ./l0_setup.sh
  sudo chmod +x ./l0a_apt_install.sh
  sudo chmod +x ./l1_copy_dotfiles.sh
  sudo chmod +x ./l2_init_workspace.sh
  ./l0_setup.sh
  ./l0a_apt_install.sh
  ./l1_copy_dotfiles.sh
  ./l2_init_workspace.sh
  
  ```

  

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

