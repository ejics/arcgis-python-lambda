region="ap-northeast-1"
account_id="<account_id>"
repo_name="my-app-repo"

# ECRにログイン
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $account_id.dkr.ecr.$region.amazonaws.com

# レポジトリを作成
aws ecr create-repository --repository-name $repo_name

# イメージにタグを付け
docker tag lambda-container:latest $account_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest

# イメージをECRにプッシュ
docker push $account_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest
