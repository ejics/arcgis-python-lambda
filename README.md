# arcgis-python-lambda
ArcGIS API for Python を AWS Lambda で利用する。

## 実行手順
1. terraform init の実行<br/>
   → `terraform init`<br/>

2. src/build-lamda.sh を実行<br/>
   → toggletree 上で "build-lamda.sh" を右クリック → "Run"

3. src/push-ecr.sh を実行<br/>
   → toggletree 上で "push-ecr.sh" を右クリック → "Run"

4. Terraformの実行<br/>
   → "terrafirm.tfvars"に、ECRのimage_uriを設定。<br/>
   例) <account_id>.dkr.ecr.ap-northeast-1.amazonaws.com/my-app-repo:latest<br/>
   → `terraform apply`<br/>

## 補足（Amazon Linux 2023 で pip コマンドにより環境構築する場合）
1. 事前に必要な開発ツールをインストール
sudo yum groupinstall "Development Tools"
sudo yum install -y bzip2-devel ncurses-devel libffi-devel readline-devel openssl-devel zlib-devel

2. pyenvのインストール
curl https://pyenv.run | bash

3. パスを通す
~/.bash_profile
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

4. python3.12のインストール
pyenv install 3.12.6
# python3.12.1に切り替え
pyenv global 3.12.6
# バージョンの確認
python -V

5. Amazon Linux 2023 でpipをアップグレードする。<br/>
→ `python -m pip install --upgrade pip`<br/>

