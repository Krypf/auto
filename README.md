# rst/

The main code is restart_app.sh.  
よく使うアプリを再起動するためのフォルダです。  
> This is a folder for restarting frequently used applications.

rst は restart の頭文字です。  
> rst is an acronym for restart.

# Sleep

xsleep.sh と wakeup.sh で対になっています。  
> xsleep.sh and wakeup.sh are paired.

# start.sh

start.sh はよく使うアプリを パソコン起動後に一度に開けます。  
> start.sh opens frequently used applications at once after the computer has started.


# arXiv

recent.sh は arXiv のページを開きます。  
> recent.sh opens an arXiv page.

# config

## MakePassword

使う前に、

```
NUM_DIGITS=3
ALPHABETS=7
PREFIX=Prefix
INTER=!!
SYMBOL=?
```

のようにして、`config` の中に `args.env` を保存してください。右辺に設定を入力してください。  
> Before using, save `args.env` in `config` as above. Enter your settings on the right side.

```
usage: MakePassword.py [-h] [-n NUM_DIGITS] [-a ALPHABETS] [-p PREFIX] [-i INTER] [-s [SYMBOL]] [-d]

Process optional arguments.

options:
  -h, --help            show this help message and exit
  -n NUM_DIGITS, --num_digits NUM_DIGITS
                        Number of digits
  -a ALPHABETS, --alphabets ALPHABETS
                        Number of alphabets
  -p PREFIX, --prefix PREFIX
                        Prefix strings
  -i INTER, --inter INTER
                        Intermediate symbols
  -s [SYMBOL], --symbol [SYMBOL]
                        Symbol strings [If no argument is given, it returns the constant empty string ''.]
  -d, --duplication     Enable duplication of numbers
```

* You can generate a password by the `generate_password(self)` function.
* You can change the length of the password however you like.
* You can use any permitted `Prefix strings`, `Intermediate symbols`, and `Symbol strings`
* If you don't need numbers without duplication, you should turn on the option `-d, --duplication`. Otherwise, duplication of numbers is forbidden.

DeepL translation

* `generate_password(self)` 関数でパスワードを生成できます。
* パスワードの長さは自由に変更できます。
* 許可された `Prefix strings`, `Intermediate symbols`, `Symbol strings` のどれでも使用可能です。
* 重複のない数字が必要ない場合は、オプション `-d, --duplication` をオンにして、重複が OK であることを宣言する必要があります。それ以外は、数字の重複を禁止します。

## links

1.  https://docs.python.org/ja/3/library/string.html
1.  https://www.python.org/dev/peps/pep-0506/

## Probability of the same number appearing

The probability of the same number appearing can be calculated as follows.

```python
y = 1
for N in range(10):
    for j in range(N):
        y *= (10 - j) / 10 
    print(N, 1 - y)
"""
0 0
1 0.0
2 0.09999999999999998
3 0.35199999999999987
4 0.6734079999999999
5 0.9012385792
6 0.98506727317504
7 0.9990968686816264
8 0.9999836135853595
9 0.9999999405369786
"""
```

# wifi

Wi-Fi のテザリングを手動で設定するのがめんどくさすぎるので自動化することにしました。

1. SSID と Password を args.env に保存します。
2. `wifi/tethering.sh` を `sh` コマンドで実行します。
3. テザリングを１度試行した後、つながるまで 10 回接続プログラムを繰り返します。

Wi-Fi の SSID とパスワードを `~/auto/wifi/args.env` に保存することで、プログラムが設定を Shell script に渡すことができます。