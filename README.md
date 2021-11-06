# 概要
オレオレ環境構築スクリプト。いったんWSL2（Ubuntu-20.04）を想定。

# 準備
## リポジトリのclone
sshの設定はまだの前提なので、httpでcloneする。
```
git clone https://github.com/dr666m1/setting.git ~/.setting
```
後でsshを利用したくなったら以下のようにする。

```
git remote set-url origin git@github.com:dr666m1/setting.git
```

# 実行
## 実行方法
ログを記録したい場合は以下のように実行
```
./scripts/init.sh 2>&1 | tee ./init.log
```

## 設定事項
- curl, zip, exaなど基本的なコマンド群のインストール
- mecabのインストール
- fishの設定（functionsなど）
- wsl2の設定
- sshの設定（鍵の作成など）
- gitの設定
- nodejsのインストール
- claspのインストール（利用前に[APIの有効化](https://script.google.com/home/usersettings)が必要）
- neovimのインストール
- pyenvのインストール
- rustのインストール
- goのインストール
- google-cloud-sdkのインストール

## 追加対応
`init.sh`の実行後に、シェルを再起動し以下の対応をする。

### pyenv
```
ver="3.7.0"
pyenv install $ver
pyenv global $ver
```

### neovim
```
pip install pynvim
```
初回はnvim内で`:PlugInstall!`を実行する必要がある。

coc.nvimのプラグインは必要に応じて`:CocInstall xxx`でインストール。
以下はお気に入り（なるべく`init.vim`に記載するようにしているので、うまくいかなかったもののみ）。

* [coc-rls](https://github.com/neoclide/coc-rls)

### docker
[Docker Desktop WSL2 backend](https://docs.docker.com/docker-for-windows/wsl/)を利用可能にしておくとよい。
動作不良の場合は`~/.docker`の削除を試す。
もしくはこの[issue](https://github.com/docker/compose/issues/7495)が参考になるかもしれない。

