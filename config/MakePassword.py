# %% MakePassword
from random import shuffle #choice,
import secrets
import string
import clipboard

# L = string.ascii_lowercase + string.ascii_uppercase + string.digits + string.punctuation
def p(L,n):# select elements of a password
    # sum([choice(L) for j in range(n)],"") sum() can't sum strings [use ''.join(seq) instead]
    return ''.join([secrets.choice(L) for j in range(n)])

def eliminate_duplication(N,n):
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
    x = eliminate_duplication(N,n) + p(A,a) + symbol
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
