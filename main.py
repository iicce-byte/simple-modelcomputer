import argparse
import re

def convert_line(line: str) -> str:
    bin_str = re.sub(r'\s+', '',line)
    num = int(bin_str, 2)
    hex_str = format(num, '06X')
    return hex_str

def main():
    parser = argparse.ArgumentParser(description=
                                     'Convert binary strings to 6-digit hex.')
    parser.add_argument('-i', '--input', type=str,
                        required=True, help='Input file path')
    parser.add_argument('-o', '--output', type=str,
                        required=True, help='Output file path')
    args = parser.parse_args()
    with open(args.input, 'r', encoding='utf-8') as infile, \
         open(args.output, 'w', encoding='utf-8') as oufile:
        for line in infile:
            res = convert_line(line)
            if res is not None:
                oufile.write(res+'\n')
                print(res)

if __name__ == "__main__":
    main()
