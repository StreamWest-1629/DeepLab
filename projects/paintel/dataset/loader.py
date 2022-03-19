# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.13.7
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %% [markdown]
# # データセットの読み込み

# %% [markdown]
# ## ライブラリを読み込む

# %%
from __future__ import annotations

import os
import re
import sqlite3
import urllib

import pandas as pd
from pandas import DataFrame

# %% [markdown]
# ## データセットディレクトリの確定

# %%
# !mkdir /dataset/paintel

# %%
DATASET_DIR = "/dataset/paintel"
PANDAS_AUTHORS = f"{DATASET_DIR}/authors.csv"
PANDAS_TWEETS = f"{DATASET_DIR}/tweets.csv"
PANDAS_IMAGES = f"{DATASET_DIR}/images.csv"

# %% [markdown]
# ### データベースの読み込み

# %% [markdown]
# 作成するテーブルは以下のとおりである．
#
# | テーブル名 | 内容 | 依存先 |
# | :-: | :-- | :-- |
# | tweets | ツイート内容に関するテーブル | `authors` |
# | images | 画像に関するテーブル | `tweets` |
# | authors | 制作者（Twitterユーザー）に関するテーブル | 最上位 |

# %%
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


# %% [markdown]
# ## 関数の定義

# %% [markdown]
# ### ツイートの登録

# %%
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


# %% [markdown]
# ### TODO: 特定のツイートの画像データを列挙

# %%
images
