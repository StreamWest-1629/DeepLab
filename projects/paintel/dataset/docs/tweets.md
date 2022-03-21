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

# ツイートデータの取得


## ライブラリを読み込む

```python
from __future__ import annotations

import json
import os
from typing import Iterable

from urllib3 import PoolManager

http = PoolManager()
```

## 環境変数の設定

```python
TWITTER_BEARER = os.getenv("TWITTER_BEARER")
PAINTEL_LISTID = os.getenv("PAINTEL_LISTID")

bearer = f"Bearer {TWITTER_BEARER}"
```

## 関数の定義


### Twitterリストからアカウント情報を取得する

```python
def get_listed_memberids(list_id: str, max_result: int = -1) -> Iterable[str]:

    global bearer
    global http
    
    # initialize
    url = f"https://api.twitter.com/2/lists/{list_id}/members"
    headers = {"Authorization": bearer}
    count, next_token, result = 100, None, []

    while count == 100:

        # set parameters
        params = {
            "max_results": 100 if max_result < 0 else min(100, max_result)
        }
        if next_token != None:
            params["pagination_token"] = next_token

        # http get method
        http_req = http.request("GET", url, headers=headers, fields=params)
        http_res = json.loads(req.data)
        
        # parse response
        result += [accounts["id"] for accounts in http_res["data"]]
        count = res["meta"]["result_count"]
        
        if count == 100:
            next_token = res["meta"]["next_token"]
            max_result -= 100
    
    return result
```
