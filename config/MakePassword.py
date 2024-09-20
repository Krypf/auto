#%% 
from random import shuffle
import secrets
import string
import clipboard
from arguments import get_args, num_digits, alphabets, prefix, inter, symbol, duplication
#%%
class Fireworks:# KeyShop
    def __init__(self, num_digits: int, alphabets: int, prefix: str, inter: str, symbol: str, duplication=False):
        self.num_digits = num_digits
        self.alphabets = alphabets
        self.prefix = prefix
        self.inter = inter
        self.symbol = symbol
        self.duplication= duplication
        
    def generate_password(self):
        Alphabets = string.ascii_lowercase + string.ascii_uppercase
        # abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
        if self.duplication:
            Numbers = string.digits # 0123456789
            x = select_password_elements(Numbers, self.num_digits)
        else:
            x = self.num_wo_duplication()
        x = x + select_password_elements(Alphabets, self.alphabets) + self.symbol
        x_list = list(x); shuffle(x_list);
        x = ''.join(x_list)
        x = self.prefix + self.inter + x
        return x
    
    def num_wo_duplication(self):
        Numbers = string.digits # 0123456789
        m = 0 # match
        n = self.num_digits # setting
        if n > 10:
            exit("The number of digits too large")
        x = str() # answer
        print("Generate digits all different from each other: (ans, new)")
        while m < n:
            num_this_time = n - m
            num_str = select_password_elements(Numbers, num_this_time)
            print((x, num_str), end=" -> ")
            x += ''.join(set(num_str))# add num_str to x
            x = ''.join(set(x))# eliminate duplication of the new number
            m = len(x)
        print('Numbers without duplication generated.')
        return x

    def initialize_args(self, args):
        if not any(vars(args).values()):
            print("INFO: Default arguments.")
        if args.num_digits:
            self.num_digits = args.num_digits
        if args.alphabets:
            self.alphabets = args.alphabets
        if args.prefix:
            self.prefix = args.prefix
        if args.inter:
            self.inter = args.inter
        if args.symbol:
            self.symbol = args.symbol
        if args.duplication:
            self.duplication = args.duplication
            print("INFO: Numbers can duplicate.")
                        
        print('args:', self.__dict__)
        return self

"""
Classification of LiteralString
* string.ascii_lowercase
* string.ascii_uppercase
* string.digits
* string.punctuation
"""
def select_password_elements(L, num_select: int):
    # sum([choice(L) for j in range(n)],"") sum() can't sum strings. Use ''.join(seq) instead.
    return ''.join([secrets.choice(L) for _ in range(num_select)])

#%%
def main(obj: Fireworks):
    args = get_args()
    #get the password with symbols & prefix options
    obj = obj.initialize_args(args)
    X = obj.generate_password()
    clipboard.copy(X)

    print(f'A password with {obj.num_digits} numbers and {obj.alphabets} alphabets, whose length is {len(X)}, was generated and copied to the clipboard!')
    print(X)

if __name__ == '__main__':
    key_symbol = Fireworks(
        num_digits=num_digits, 
        alphabets=alphabets, 
        prefix=prefix, 
        inter=inter, 
        symbol=symbol,
        duplication=duplication
    )
    main(key_symbol)
