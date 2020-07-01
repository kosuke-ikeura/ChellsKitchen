調味料を調整するサービス Chell's Kitchen
====


Chell's Kitchenは開発者が住んでいるチェルシーハウス国分寺発の調味料調整サービスです。\
\
<img width="1277" alt="スクリーンショット 2020-04-18 22 51 16" src="https://user-images.githubusercontent.com/45197982/79640279-ac764e00-81cb-11ea-9d8b-379375e6d46c.png">
## 作成した経緯
開発者が住んでいるチェルシーハウス国分寺は40人規模のシェアハウスです。 \
シェアハウスの調味料の費用は、4月にみんなが出し合ったお金から経費として出ます。 \
調味料を買うのは、シェアハウス内の学生で、最寄りのスーパーで購入した後はレシートを担当者に渡して返金してもらう形をとっていました。 \
Chell's Kitchenは調味料購入から返金までの流れを円滑にするWebサービスです。

## リンク
https://chealseasuke.com

## 機能詳細一覧
- ユーザー関係
	- 新規登録、ログイン、ログアウト、簡単ログイン
	- マイページ
	- マイページにて過去に購入した調味料と合計金額を表示
- 調味料関係
	- 調味料一覧表示
	- モーダルフォームで調味料のステータスを変更
	- ステータスは1~3であり、1になるとシェアハウスの学生にステータスが1である調味料をメールで通知
	- 上記のメールの確認はしないようお願いします。
	- 検索機能
	- 調味料購入を報告するフォーム
	- 画像(レシート)投稿

## 使用画面
<img width="650" alt="スクリーンショット 2020-07-01 19 43 23" src="https://user-images.githubusercontent.com/45197982/86235377-4cd8ed80-bbd3-11ea-8ff6-7ace6344272d.png">
<img width="650" alt="スクリーンショット 2020-07-01 19 43 38" src="https://user-images.githubusercontent.com/45197982/86235395-51050b00-bbd3-11ea-9ffa-23ff68d11232.png">
<img width="650" alt="スクリーンショット 2020-07-01 19 43 46" src="https://user-images.githubusercontent.com/45197982/86235398-519da180-bbd3-11ea-9993-bec3cfac6d87.png">
<img width="650" alt="スクリーンショット 2020-07-01 19 43 54" src="https://user-images.githubusercontent.com/45197982/86235399-52363800-bbd3-11ea-82b3-c7c3140c9282.png">
<img width="650" alt="スクリーンショット 2020-07-01 19 44 02" src="https://user-images.githubusercontent.com/45197982/86235401-52363800-bbd3-11ea-9c75-65c5a6504d00.png">

使用技術
## 技術のこだわりポイント
### ローカルをDockerで構成
ローカルの環境はRails(puma) + Nginx + MySQLで構成しています。


## 言語・フレームワーク・インフラ 

### バックエンド
Ruby 2.5.1 \
Ruby on Rails 5 

### フロントエンド
JavaScript \
jQuery

### 開発環境
Docker
docker-compose

### コンテナ構成
1. Rails(App) 
2. Nginx(Web) 
3. MySQL(DB) 

### インフラストラクチャー
- Mysql
- Nginx
- Docker
- docker-compose
- Circleci
- Terraform

### AWS
- ACM
- CloudWatch
- ALB
- ECR/ECS(FARGATE)
- RDS
- Route53
- VPC

### インフラアーキテクチャ
![Untitled Diagram](https://user-images.githubusercontent.com/45197982/86240903-f40e5280-bbdc-11ea-80b5-2b0122ee423b.png)



