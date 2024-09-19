# %% MakePassword
from random import shuffle #choice,
import secrets
import string
import clipboard

# L = string.ascii_lowercase + string.ascii_uppercase + string.digits + string.punctuation
def p(L,n):# select elements of a password
    # sum([choice(L) for j in range(n)],"") sum() can't sum strings [use ''.join(seq) instead]
    return ''.join([secrets.choice(L) for j in range(n)])

def q(N,n):# eliminate duplication
    print('Numbers without duplication are:')
    m = 0
    while m < n:
        num = p(N,n)
        m = len(set(num))
        print(m, num)
    return num

def gen(n,a,symbol,pre):# generate the password
    N = string.digits# Numbers
    A = string.ascii_lowercase + string.ascii_uppercase# Alphabets
    x = q(N,n) + p(A,a) + symbol
    # print(x)
    X = list(x)# list made 
    shuffle(X)
    X = pre +''.join(X)# joined
    return X

def main(n,a,symbol='',pre=''):#get the password with symbols & prefix options
    X = gen(n,a,symbol,pre)
    clipboard.copy(X)

    print(f'A password with {n} numbers and {a} alphabets, whose length is {len(X)}, was generated and copied to the clipboard!')
    print(X)
n = 5; a = 5; 
main(n,a,pre='=',symbol='!#@?')
# %% Readme
# You can change the length of the password however you like.
# You are free to choose what letters compose the password by rewriting x in the gen() function.
# If you don't need numbers without duplication, you should turn q(N,n) in x into p(N,n).
# You can use any permitted symbols and any fixed prefix.
# %% DeepL translation
# パスワードの長さを自由に変更することができます。
# gen()関数でxを書き換えることで、パスワードを構成する文字を自由に選ぶことができます。
# 重複しない数字が必要ない場合は, xのq(N,n)をp(N,n)に書き換えてください.
# 許可された記号や固定の接頭辞を使用することができます。
# %% links
# https://docs.python.org/ja/3/library/string.html
# https://www.python.org/dev/peps/pep-0506/


# %% Probability of the same number appearing
# from math import factorial
# y = 1
# for N in range(10):
#     for j in range(N):
#         y *= (10 - j) / 10 
#     print(N, 1 - y)
# 0 0
# 1 0.0
# 2 0.09999999999999998
# 3 0.35199999999999987
# 4 0.6734079999999999
# 5 0.9012385792
# 6 0.98506727317504
# 7 0.9990968686816264
# 8 0.9999836135853595
# 9 0.9999999405369786
