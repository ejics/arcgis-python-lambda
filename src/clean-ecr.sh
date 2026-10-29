region="ap-northeast-1"
account_id="<account_id>"
repo_name="my-app-repo"

# ECRにログイン
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $account_id.dkr.ecr.$region.amazonaws.com

# イメージタグ削除
aws ecr batch-delete-image --repository-name $repo_name --image-ids imageTag=latest

#  リポジトリを削除
aws ecr delete-repository --repository-name $repo_name --force