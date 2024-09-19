#%% 
from random import shuffle
import secrets
import string
import clipboard
from arguments import get_args

#%% 
class Fireworks:# KeyShop
    def __init__(self, n: int, a: int, pre: str, symbol: str):
        self.num_digits = n
        self.alphabets = a
        self.prefix = pre
        self.symbol = symbol
        
    def generate_password(self):
        Numbers = string.digits
        Alphabets = string.ascii_lowercase + string.ascii_uppercase
        x = eliminate_duplication(Numbers, self.num_digits) + select_password_elements(Alphabets, self.alphabets) + self.symbol
        # print(x)
        X = list(x)# list made 
        shuffle(X)
        X = self.prefix + ''.join(X)
        return X
    
    def initialize_args(self, args):
        if args.num_digits:
            self.num_digits = args.num_digits
        if args.alphabets:
            self.alphabets = args.alphabets
        if args.prefix:
            self.prefix = args.prefix
        if args.symbol:
            self.symbol = args.symbol
        else:
            print("Default arguments.")
        return self

"""
Classification of LiteralString
* string.ascii_lowercase
* string.ascii_uppercase
* string.digits
* string.punctuation
"""
def select_password_elements(L, n: int):
    # sum([choice(L) for j in range(n)],"") sum() can't sum strings. Use ''.join(seq) instead.
    return ''.join([secrets.choice(L) for _ in range(n)])
#%%
def eliminate_duplication(Numbers, n: int):
    print('Numbers without duplication are:')
    m = 0
    while m < n:
        num_str = select_password_elements(Numbers, n)
        m = len(set(num_str))
        print(m, num_str)
    return num_str


#%%
def main(obj: Fireworks, args):
    #get the password with symbols & prefix options
    obj = obj.initialize_args(args)
    X = obj.generate_password()
    clipboard.copy(X)

    print(f'A password with {obj.num_digits} numbers and {obj.alphabets} alphabets, whose length is {len(X)}, was generated and copied to the clipboard!')
    print(X)

if __name__ == '__main__':
    key_symbol = Fireworks(n=5, a=5, pre='=', symbol='!#@?')
    # make_numbers = Fireworks(n=14, a=0, pre='', symbol='_')
    args = get_args()
    main(key_symbol, args)
