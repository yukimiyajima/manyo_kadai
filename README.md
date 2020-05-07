# README
## taskテーブル
|  カラム名  | データ型  |
|  :---     | :---    |
| title     | string  |
| content   | text    |
| id        |


## userテーブル
|  カラム名          | データ型  |
|  :---            | :---    |
| name             | string  |
| email            | string  |
| password_digest  | string  |
| id               |


## 中間テーブル
|  カラム名   |
|  :---      |
| task_id    |
| user_id    |  



## labelテーブル
|  カラム名   | データ型  |
|  :---      | :---    |
| label_name | string  |
| id         |  


## Herokuデプロイ手順
---
まずherokuにログイン
```
% heroku login
```

herokuにアプリを作成
```
% heroku create
```

プリコンパイル
```
% rails assets:precompile
```

herokuのbuildpackにrubyパッケージセット
```
% heroku buildpacks:set heroku/ruby
```

herokuのbuildpackにnodejsパッケージ追加
```
% heroku buildpacks:add --index 1 heroku/nodejs
```

master（gitの）にpush
```
% git add .
% git commit -m 'heroku'
% git push origin master
```

herokuへデプロイする
```
% git push heroku master
```

herokuでdb:migrateする
```
% heroku run rails db:migrate
```

アプリへ移動して確認
```
% heroku open
```
