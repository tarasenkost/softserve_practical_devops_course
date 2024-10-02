# Count the number of lines in a text file that start with the string "log". The code should use regular expressions

import re

def count_log_files(filename):
    number_of_lines = 0
    with open(filename, 'r') as file:
        for line in file:
            if re.match(r'^log', line):
                number_of_lines += 1
    return number_of_lines

test_file = "testfile_task2.txt"
print(count_log_files(test_file))