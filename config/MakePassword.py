# %% MakePassword
from random import shuffle
import secrets
import string
import clipboard

# L = string.ascii_lowercase + string.ascii_uppercase + string.digits + string.punctuation
def select_password_elements(L, n):
    # sum([choice(L) for j in range(n)],"") sum() can't sum strings [use ''.join(seq) instead]
    return ''.join([secrets.choice(L) for j in range(n)])

def eliminate_duplication(N, n):
    print('Numbers without duplication are:')
    m = 0
    while m < n:
        num = select_password_elements(N, n)
        m = len(set(num))
        print(m, num)
    return num

def generate_password(n, a, pre, symbol):
    Numbers = string.digits
    Alphabets = string.ascii_lowercase + string.ascii_uppercase
    x = eliminate_duplication(Numbers, n) + select_password_elements(Alphabets, a) + symbol
    # print(x)
    X = list(x)# list made 
    shuffle(X)
    X = pre + ''.join(X)# joined
    return X

def main(n, a, pre='', symbol=''):
    #get the password with symbols & prefix options
    X = generate_password(n, a, pre=pre, symbol=symbol)
    clipboard.copy(X)

    print(f'A password with {n} numbers and {a} alphabets, whose length is {len(X)}, was generated and copied to the clipboard!')
    print(X)
n = 5; a = 5; 
main(n, a, pre='=', symbol='!#@?')
