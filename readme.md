# infix

中置記法の電卓のようなマクロの習作です.

## 使い方

### インストール

```
$ ros install myaosato/infix
```

or

```
$ git clone https://github.com/myaosato/infix.git
```

etc...

### ロード

```
CL-USER> (ql:quickload :infix)
```

or

```
CL-USER> (asdf:load-asd "/your/path/infix/infix.asd")
CL-USER> (asdf:load-system :infix)
```

etc...

### 計算

```
CL-USER> (infix/infix:infix 3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3)
24577/8192
```

### 使える演算子

- `+`
- `-`
- `*`
- `/`
- `^` (exptに変換する)

## 参考

[操車場アルゴリズム - Wikipedia -](https://ja.wikipedia.org/wiki/%E6%93%8D%E8%BB%8A%E5%A0%B4%E3%82%A2%E3%83%AB%E3%82%B4%E3%83%AA%E3%82%BA%E3%83%A0)

## Licence

MIT
