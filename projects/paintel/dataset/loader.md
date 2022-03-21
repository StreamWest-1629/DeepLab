---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.7
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

# データセットの読み込み


## ライブラリを読み込む

```python
from __future__ import annotations

import os
import re
import sqlite3
import urllib
from typing import Iterable

import pandas as pd
from pandas import DataFrame
from PIL import Image
```

## データセットディレクトリの確定

```python
!mkdir /dataset/paintel
```

```python
DATASET_DIR = "/dataset/paintel"
PANDAS_AUTHORS = f"{DATASET_DIR}/authors.csv"
PANDAS_TWEETS = f"{DATASET_DIR}/tweets.csv"
PANDAS_IMAGES = f"{DATASET_DIR}/images.csv"
```

### データベースの読み込み


作成するテーブルは以下のとおりである．

| テーブル名 | 内容 | 依存先 |
| :-: | :-- | :-- |
| tweets | ツイート内容に関するテーブル | `authors` |
| images | 画像に関するテーブル | `tweets` |
| authors | 制作者（Twitterユーザー）に関するテーブル | 最上位 |

```python
authors, tweets, images = None, None, None

if os.path.exists(PANDAS_AUTHORS) == False or os.path.exists(
        PANDAS_TWEETS) == False or os.path.exists(PANDAS_IMAGES) == False:
    authors = DataFrame(columns=["id", "name", "followers"])
    tweets = DataFrame(columns=["id", "author_id", "content"])
    images = DataFrame(columns=["id", "tweet_id", "url", "filepath"])
else:
    authors = pd.read_csv(PANDAS_AUTHORS)
    tweets = pd.read_csv(PANDAS_TWEETS)
    images = pd.read_csv(PANDAS_IMAGES)
```

### データベースの保存関数の定義

```python
def save_db():
    authors.to_csv(PANDAS_AUTHORS)
    tweets.to_csv(PANDAS_TWEETS)
    images.to_csv(PANDAS_IMAGES)
```

## 関数の定義


### ツイートの登録

```python
def register_tweet(author_id: str, author_name: str, author_followers: int,
                   tweet_id: str, tweet_content: str, image_id: str,
                   image_url: list[str]):

    global tweets
    global authors
    global images

    # register tweet
    if (tweets["id"] == tweet_id).sum() > 0:
        return
    else:
        tweets = pd.concat([
            tweets,
            DataFrame([{
                "id": tweet_id,
                "author_id": author_id,
                "content": tweet_content,
            }])
        ])

    # register author
    if (authors["id"] == author_id).sum() > 0:
        authors[authors["id"] == author_id]["name"] = author_name
        authors[authors["id"] == author_id]["follwers"] = author_followers
    else:
        authors = pd.concat([
            authors,
            DataFrame([{
                "id": author_id,
                "name": author_name,
                "followers": author_followers,
            }])
        ])

    # save and register images
    for url in image_url:
        path = f"{DATASET_DIR}/images/{tweet_id}/{re.findall(r'[^/]+$', url)[0]}"
        urllib.request.urlretrieve(url, path)
        images = pd.concat([
            images,
            DataFrame([{
                "id": image_id,
                "tweet_id": tweet_id,
                "url": url,
                "filepath": path,
            }])
        ])
```

### 特定のツイートの画像データを列挙

```python
def enum_tweet_images(image_id: str) -> Iterable[Image]:

    global images

    return [
        Image.open(filepath) for filepath in images[
            images["image_id"] == image_id]["filepath"].items()
    ]
```

### 特定のユーザーの保存済みのツイートデータを列挙

```python
def enum_author_tweetids(author_id: str) -> Iterable[str]:

    global tweets

    return tweets[tweets["author_id"] == author_id]["tweet_id"].items()
```
