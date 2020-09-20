# 概要
オレオレ環境構築スクリプト。いったんはWSL2（Ubuntu-18.04・Debian）を想定。

# 準備
## fishのインストール
スクリプトはfish用に記載しているため、事前にインストールが必要。完了したらシェルを再起動。
```
# install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get -y install fish

# change default shell
chsh -s $(which fish)
```

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
mkdir -p ./log
./init.fish 2>&1 | tee ./log/stdout_and_stderr.log
```

## 設定事項
- curl, zip, exaなど基本的なコマンド群のインストール
- 自作ツールの設定（watcherなど）
- mecabのインストール
- fishの設定（functionsなど）
- wsl2の設定
- sshの設定（鍵の作成など）
- gitの設定
- nodejsのインストール
- claspのインストール（利用前に[APIの有効化](https://script.google.com/home/usersettings)が必要）
- neovimのインストール
- pyenvのインストール
- google-cloud-sdkのインストール

## 追加対応
`init.fish`の実行後に、シェルを再起動し以下の対応をする。

### google-cloud-sdk
```
set -Ux GOOGLE_APPLICATION_CREDENTIALS $HOME/.gcp/xxxxxx.json
```

### pyenv
```
set -l ver "3.7.0"
pyenv install $ver
pyenv global $ver
```

### neovim
```
pip install pynvim
```
初回はnvim内で`:call dein#install()`（と、もしかしたら`:UpdateRemotePlugins`）を実行する必要がある。

### omf
omfやそのテーマを使いたければ、以下のように実行する。
あくまでテーマの管理に利用する想定で、いまのところ`~/.config/omf/init.fish`を使うつもりはない。
```
curl -L https://get.oh-my.fish | fish
omf install batman
```

### docker
[Docker Desktop WSL2 backend](https://docs.docker.com/docker-for-windows/wsl/)を利用可能にしておくとよい。
`docker-compose`の動作不良の場合は`~/.docker`の削除を試す。
もしくはこの[issue](https://github.com/docker/compose/issues/7495)が参考になるかもしれない。
