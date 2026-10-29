# すべてのビルドキャッシュを削除
docker builder prune -a

# ビルド
docker build -t lambda-container:latest .

# ローカルで実行テスト
#docker run -p 9000:8080 lambda-container:latest

# 別ターミナルから
#curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'