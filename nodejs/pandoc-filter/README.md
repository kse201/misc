# pandoc-filter

## Description

Markdown→Textile にPandocで変換かけた際の微修正をフィルタで自動化します。

- コードブロックの HTML記法での表記 & コードタイプ指定
- `->` が `&#45;&bt;` になってしまう問題を、 `→` にして回避する。
- 上と同様に `=>` を `⇒` に回避修正。

## install


```
yarn install
```

※ TODO なぜか `pandoc-filter` をglobal install しても `require` できない問題の解決

## Usage

```
pandoc <src.md>  -o <dest.textile> --filter=./forRedmine.js
```
