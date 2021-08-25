# REPIHAPI
## URL　
https://repihapi.com
<img width="1429" alt="トップページ2" src="https://user-images.githubusercontent.com/85467321/130827904-8ad09271-c453-4201-9ed1-b5a26c2c4ba6.png">

## サービスの概要
テーマ：健康的な食生活を送るためのお手伝いをする
「食事の献立を考える」「栄養素やカロリーを計算する」「何を食べたかを記録する」など、健康になるための食事を継続するには、時間と手間がかかってしまいます。
REPIHAPIは、上記のような面倒なことを、ユーザーの代わりに行うWebアプリケーションです。

## 制作背景
私は、酒さという顔の肌に赤みが出たり、ほてりが起きたりする慢性の皮膚疾患を持っています。
中学生のころ、酒さであることが分かり、食べものによっては症状を悪化させてしまうことから、毎日食べたものを記録するようになり、それがきっかけで自分に合った健康的な食事に興味を持つようになりました。
しかし、「レシピを探して献立を考える」「栄養素やカロリーを計算する」「実際に何を食べたかを記録する」など、日々の食事の管理や記録を取ることはとても大変で、健康的で自分に合った食生活が、なにか分かるまでにとても時間がかかりました。
上記のように大きな手間がかかってしまうという理由で、健康になりたいが、食生活をなかなか変えられず悩んでいる人は多くいると考え、制作をしようと思いました。

## 使用技術
◆フロントエンド
- HTML
- SCSS / Tailwind.css
- JavaScript

◆バックエンド
- Ruby 3.0.0
- Ruby on Rails 6.1.3.2
- Rspec
- Rubocop

◆開発環境・本番環境・インフラ
- Docker / docker-compose（開発環境）
- MySQL 8.0.23
- AWS （VPC / EC2 / Route53 / S3 / RDS / ACM / ALB / CloudFront / IAM）
- Nginx
- Circle CI
- Capistrano

## 機能
◆ユーザー
- 新規登録 / 一覧・詳細表示 / 編集 / 退会
- ログイン / ゲストログイン / Google OAuth2 / Cookieを利用した永続的セッション
- フォロー [Ajax]
- フォロー・フォロワー表示
- 検索

◆投稿
- 新規作成 / 一覧・詳細表示 / 編集 / 削除
- 画像（添付 / プレビュー / リサイズ）
- タグ（追加 / 検索 / 同じタグが付いた投稿の一覧表示）
- カロリー自動計算
- お気に入り[Ajax]
- コメント（新規作成 / 削除）[Ajax]
- 検索
- 並び替え（新着 / カロリー昇順・降順）
- ランキング
- 閲覧履歴（閲覧した投稿の直近20件のみを保存・表示）

◆食事記録（Webサイト内の投稿で実際に食べたものを記録・管理できる機能）
- 新規追加
追加時の投稿の情報をDBに保存し、投稿の情報更新や削除の影響を受けないよう設計
- 一覧表示
１ヶ月ごとの食事記録をカレンダーに表示
- 削除
- 月ごとの平均カロリーと栄養素のバランスを算出・表示
- グラフ（カロリーと栄養素のバランスを表示）

◆その他
- 通知（フォロー / お気に入り / コメント）
- レスポンシブデザイン
- 常時SSL化

## 開発の際こだわったところ
### (1)RSpecやRubocopを用いたコードの品質管理
機能の実装をする上で、要件を満たしているか、不具合が発生しないかを客観的に確認できる仕組みを設けることは、サービスを継続的に運用していく上で重要なことだと考えました。
そのため、RSpecを導入し、CircleCIによる自動テストを実施することで、バグを事前に検知し、本番環境での運用に支障が生じないようにしました。
テストの具体的な内容としては、Model SpecとRequest Specの２種類を使用し、正常系・異常系のテストを実施しました。また、同値分割法や境界値分析などの手法を取り入れました。
加えて、静的解析ツールとしてRubocopを導入し、コードのフォーマットや規則を管理することで品質を保つようにしました。
### (2)N+1問題の解決
サービスを持続させる上で、サービスにかかる負荷を最小限に抑えることが重要だと知りました。そのため、大きな負荷がかかるSQLの実行回数を少しでも減らすためにN+1問題を解消しました。
### (3)チーム開発を意識した開発フローと本番環境を見据えた技術構成
GitHubではissueの立ち上げ、プルリクエスト、mainブランチへのマージなど、実際の工程を意識した開発手順を行いました。また、Dockerを使用し、複数人で開発する際に課題となる、開発者間での環境の差異による不具合が起こらないようにしました。
本番環境では、インフラにAWS、CI / CDにCircleCI、自動デプロイにCapistranoを利用し、継続的なサービスの運用を行うためのシステムを構築しました。
### (4)食事記録機能のDB設計
記録をする機能で重要なことは、記録時の情報が変更・改ざんされないこと、削除されないことだと考えました。そのため、本サービスの機能の一つである食事記録機能は、記録時の投稿の情報を記録用テーブルに保存することで、上述の問題を解決するようにしました。

## インフラ構成図
![AWS構成図 (4)](https://user-images.githubusercontent.com/85467321/130824222-54bc2992-1030-4fc3-8c4d-d2d0af0fbaec.png)
## テーブル設計
![ER図](https://user-images.githubusercontent.com/85467321/130824636-2e70d6c8-9c9a-4fa5-b453-ca56715b1c83.png)
## 今後導入予定の機能
- RSpecのRequest Spec
- メールによる認証機能（AWSのSESを使用予定）
- Vue.jsを用いてのSPA化
- TerraformによるAWSリソースのコード化
- 本番環境にDockerを導入・ECSによるコンテナ基盤の構築

## 主な機能のページ詳細

### レシピ投稿機能（ページ左下に栄養素自動計算フォームあり）
<img width="1429" alt="投稿詳細ページ" src="https://user-images.githubusercontent.com/85467321/130825496-343f7c8f-3513-458f-be4e-09ffc3ed5466.png">

### 食事記録機能
<img width="1429" alt="食事記録機能" src="https://user-images.githubusercontent.com/85467321/130825755-5d002912-6f32-453f-8a51-9ef96bccee55.png">
<img width="1429" alt="食事記録機能2" src="https://user-images.githubusercontent.com/85467321/130825788-cf2e7962-ccab-4573-a11e-8a633a2470b4.png">
