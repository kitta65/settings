## 概要
オレオレ環境構築スクリプト。いったんはWSL2（Ubuntu-18.04）を想定。

## 準備
### fishのインストール
スクリプトはfish用に記載しているため、事前にインストールが必要。完了したらシェルを再起動。
```
# install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get -y install fish

# change default shell
chsh -s $(which fish)
```

### リポジトリのclone
sshの設定はまだの前提なので、httpでcloneする。
```
git clone https://github.com/dr666m1/setting.git ~/.setting
```
後でsshを利用したくなったら以下のようにする。

```
git remote set-url origin git@github.com:dr666m1/setting.git
```

## init.fish
### 設定事項
- curl, zip, exaなど基本的なコマンド群のインストール
- 自作ツールの設定（watcherなど）
- mecabのインストール
- fishの設定（functionsなど）
- wsl2の設定
- sshの設定（鍵の作成など）
- gitの設定
- nodejsのインストール
- claspのインストール（利用前に[APIの有効化](https://script.google.com/home/usersettings)が必要）

## gcp.fish
### 備考
サ―ビスアカウントを作成し、jsonファイルを任意の場所に保存すると各種権限を付与できる。以下のようにパスを指定すること。
```
set -Ux GOOGLE_APPLICATION_CREDENTIALS $HOME/.gcp/xxxxxx.json
```

## pyenv.fish
### 備考
実行後以下のように、任意のバージョンのインストールと設定を行う。

```
set -l ver "3.7.0"
pyenv install $ver
pyenv global $ver
```

## nvim.fish
### 準備
事前に `pyenv.fish` を実行しておく必要がある。

### 備考
初回はnvim内で`:call dein#install()`（と、もしかしたら`:UpdateRemotePlugins`）を実行する必要がある。
