import argparse

def get_args():
    parser = argparse.ArgumentParser(description="Process optional arguments.")
    
    parser.add_argument('-n', '--num_digits', type=int, help='Number of digits')
    parser.add_argument('-a', '--alphabets', type=int, help='Number of alphabets')
    parser.add_argument('-p', '--prefix', type=str, help='Prefix strings')
    parser.add_argument('-i', '--inter', type=str, help='Intermediate symbols')
    parser.add_argument('-s', '--symbol', type=str, help='Symbol strings')
    parser.add_argument('-d', '--duplication', action='store_true', help='Enable duplication of numbers')
    
    args = parser.parse_args()
    return args

from dotenv import load_dotenv
import os
# Get the current working directory
current_dir = os.path.dirname(os.path.abspath(__file__))
# Construct the absolute path to config/args.env
dotenv_path = os.path.join(current_dir, 'args.env')
# print(dotenv_path)
# Load environment variables from config/args.env file
load_dotenv(dotenv_path=dotenv_path)

# Access environment variables
num_digits = int(os.getenv('NUM_DIGITS'))
alphabets = int(os.getenv('ALPHABETS'))
prefix = os.getenv('PREFIX')
inter = os.getenv('INTER')
symbol = os.getenv('SYMBOL')
duplication = os.getenv('DUPLICATION')

def main():
    args = get_args()
    print('Example: print the values of the arguments')
    print(f"Digits: {args.num_digits}")
    print(f"Alphabets: {args.alphabets}")
    print(f"Prefix: {args.prefix}")
    print(f"Intermediate: {args.inter}")
    print(f"Symbol: {args.symbol}")

if __name__ == "__main__":
    main()
