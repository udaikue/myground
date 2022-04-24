# MyGround

## サービス概要
プロ野球(NPB)観戦が好きな人向けの観戦記録サービスです。試合結果といっしょに観戦日記と関連するニュース記事のリンクを残すことができます。

会員登録し、ログインすると観戦日記の作成・編集・削除ができます。

他のユーザーの観戦日記を閲覧することはできません。

### トップページ
![top](https://user-images.githubusercontent.com/58643754/164873657-b1bd92f0-1e24-462c-b4e4-1b7946fe342d.png)


### 対応試合について

- 2022年オープン戦
- 2022年公式戦

### 試合結果表示のタイミング

基本的に、試合終了後30分~1時間までの間に表示されるようになります。

## 画面
### 観戦日記作成の流れ

新規作成ボタンを押すと、カレンダーが表示されます。

![new](https://user-images.githubusercontent.com/58643754/164877674-ab5731a4-0252-421a-8759-3f826d197b79.png)

下線が付いた日付をクリックするとその日の対戦カードが表示されるので、試合を選択してください。

![new_card](https://user-images.githubusercontent.com/58643754/164877834-3cc87b32-77f5-4427-b24a-c90b3553b58d.png)

試合結果の下に入力フォームが表示されます。

![new_form](https://user-images.githubusercontent.com/58643754/164877893-ebcdbe94-5249-4385-8c67-9bb41ef8348f.png)

ニュースリンクを保存する場合は「リンク追加」ボタンを押します。

![new_link1](https://user-images.githubusercontent.com/58643754/164878074-7b2ea5fa-3627-40a5-9aa5-866680da57eb.png)

「リンク追加」ボタンを押すと、下記のようにタイトルが表示されます。

![new_link2](https://user-images.githubusercontent.com/58643754/164878086-f1f0985b-006e-4125-8764-d85813ba321d.png)

※「リンク追加」ボタンを押さずに「保存」ボタンを押してもニュースリンクは保存されません。

「保存」ボタンを押すと観戦日記が作成されます。


## URL

```
https://my-ground.herokuapp.com/
```

## 開発環境
- Ruby 3.0.2
- Ruby on Rails 6.1.5
- PostgreSQL 14.1
- Vue.js 2.6.14

## ローカルで起動

```
$ git clone git@github.com:udaikue/myground.git
```

```
$ cd myground
```

```
$ bin/setup
```

```
$ bin/rails s
```

## ログイン

ユーザー名: test_user1

```
Eメール: test1@example.com
パスワード: password
```

ユーザー名: test_user2

```
Eメール: test2@example.com
パスワード: password
```
