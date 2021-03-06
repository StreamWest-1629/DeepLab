# DeepLab
機械学習を行うためのJupyter Lab環境です．主にこのリポジトリで機械学習プロジェクトを進めていきます．（個人で使うものなのでしばらくはプロジェクトごとにブランチを分けるわけでもなく，このまま運用してみたいと思います）

## Issue作成（各リポジトリごとにうまい具合に設定してください）
| Project \ Issue | improve | bugfix |
| :-- | :-: | :-: |
| [Infra and Libs][@infra_and_libs] | [Make Issue][improve@infra_and_libs] | [Make Issue][bugfix@infra_and_libs] |

## git clone時にやること
**`./after_cloning.sh`を実行してください．** jupyter labのPush時に必要です．

## `docker compose up` 系デプロイコマンド

| `docker compose up xxx` | 内容 |
| :-: | :-- |
| `check_version` | コンテナ内で使用中のモジュールのバージョン情報を確認する |
| `deploy` | AWS上のリソースを追加・更新する |
| `start` | Jupyter Labを実行する |

## テンプレートとして使用したらはじめにすること
1. **readme.mdの修正，やらないと許さない**
    ```sh
    # 置換対策のためにスペースを追加しています
    # コマンドで使用するときはとしてください
    $ sed -i -e "s%streamwest-1629 / repo_template%<username> / <reponame>%g" readme.md
    ```

2. **リポジトリの設定を変更**
    1. Projectsの作成
        [make projects](https://github.com/streamwest-1629/deeplab/projects/new) から`issue and improve`プロジェクトを作成します．Templateは `Automated kanban` が良いかと思います（楽なので）．
    2. [Settings](https://github.com/streamwest-1629/deeplab/projects/settings) の `Pull Requests` から `Automatically delete head branches` の項目にチェックをつけてください．

3. **dockerfileの修正**
    - ビルド・デプロイ用にdocker (compose)を用いることを前提に組まれている．
    - そのため，`build.dockerfile` や `docker-compose.yml` をうまい具合に書き直してほしい．
        （Future Feature: 新しい言語を触るときはその都度このリポジトリのどこかにプリセットとしておいておきたい）
    > ちなみに，デフォルトではGolangを修正しやすいようにわざわざ `build.dockerfile` に記述している．

## ブランチ運用ルール（`Git-flow`ベースな感じ）

> **大前提として，およそ Issue > (fixing) > Pull request > (review) > mergeの順を守ってください**

- Issueに紐づいたブランチを作るときはIssueのDevelopmentからブランチを切る
    - Issueとブランチを紐づけて管理しやすくするため
- コミット時には必ず先頭に `#[Issue番号]:` を付ける
    - Issueから追跡できるようにするため
- ブランチ名に関しては下に示すものに加え，プロダクトに応じて `release`, `staging`, `nightly` などのブランチを用意しておく．

### ブランチ命名規則とその運用
| ブランチ名 | 運用方法 | チェックアウト/マージ先 |
| :-: | :-- | :-: |
| `main` | **開発用ブランチ．**<br/>ここで直接作業を行わないでください． | （最上位格） |
| `[Issue番号]-improve/[Issue説明]` | **機能実装系のIssueを裁く際のブランチ．**<br/>IssueのDevelopmentから作ると左記のようなブランチ名になるはず． | `main` |
| `[Issue番号]-bugfix/[Issue説明]` | **バグ修正系のIssueを裁く際のブランチ．**<br/>IssueのDevelopmentから作ると左記のようなブランチ名になるはず． | `main` |
| `[Issueベース系ブランチ名]/hotfix` | `main` ブランチ以外で修正を行う必要があるときに使用するブランチ．<br/>`123-bugfix/緊急の修正/hotfix` みたいな使い方をする． | 任意のブランチ |

<!-- Infra and Libs project -->
[@infra_and_libs]:https://github.com/streamwest-1629/deeplab/projects/1 
<!-- Make Issue in Infra and Libs project -->
[improve@infra_and_libs]:https://github.com/streamwest-1629/deeplab/issues/new?labels=enhancement&template=improve.md&title=infra%2Fimprove%2F%3C%E6%A9%9F%E8%83%BD%E3%81%AE%E7%B0%A1%E5%8D%98%E3%81%AA%E8%AA%AC%E6%98%8E%3E&projects=streamwest-1629/deeplab/1
<!-- Make Issue in Infra and Libs project -->
[bugfix@infra_and_libs]:https://github.com/streamwest-1629/deeplab/issues/new?labels=bug&template=bugfix.md&title=infra%2Fbugfix%2F%3C%E5%95%8F%E9%A1%8C%E3%81%AE%E7%B0%A1%E5%8D%98%E3%81%AA%E8%AA%AC%E6%98%8E%3E&projects=streamwest-1629/deeplab/1
