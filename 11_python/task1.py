# Using the os module, write a script that recursively searches a directory for files with a specific extension and prints their paths.

import os

def search_files(extension):
    matches = []
    for root, dirs, files in os.walk('.'):  
        for file in files:
            if file.endswith(extension):
                matches.append(os.path.basename(file))  
    return matches

    # Sort alphabetically by file name
    # return sorted(matches, key=lambda x: os.path.basename(x))

    # Sort by file name length
    # return sorted(matches, key=lambda x: len(os.path.basename(x)))


for file in search_files('.bmp'):
    print(file)



## >>>>>>>>>>>>>>>>>>>>>>>>>>>>  sort by file-size

# def get_file_size(file_path):
#     return os.path.getsize(file_path)

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.join(file))  
#     return sorted(matches, key=lambda x: get_file_size(x))


## >>>>>>>>>>>>>>>>>>>>>>>>>>>> sort by file-modification-time

# def get_file_modification_time(file_path):
#     return os.path.getmtime(file_path)

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.join(file))  
#         return sorted(matches, key=lambda x: get_file_modification_time(x))

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sort by file-creation-time

# def get_file_creation_time(file_path):
#     return os.path.getctime(file_path)

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.join(file))  
    
#     # Sort by file creation time
#     return sorted(matches, key=lambda x: get_file_creation_time(x))

## >>>>>>>>>>>>>>>>>>>>>>>>>>>> reverse-alfabetical sorting

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.join(file))  
    
#     # Sort in reverse alphabetical order
#     return sorted(matches, key=lambda x: os.path.basename(x), reverse=True)



## custom order 


# Custom order for specific file names
# custom_order = {
#     'photo.bmp': 1, 'logo.bmp': 2,
#     'users1.xml': 1, 'input.xml': 2, 'users2.xml': 3, 'config.xml': 4,
#     'data.rar': 1, 'books.rar': 2, 'info.rar': 3,
#     'new_text.txt': 1, 'smth.txt': 2, 'log.txt': 3
# }

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.basename(file))  # Use file name only
    
#     # Sort based on custom predefined order
#     return sorted(matches, key=lambda x: custom_order.get(x, float('inf')))

# # Example usage
# for file in search_files('.bmp'):
#     print(file)


#### works

# # Custom order for specific file names
# custom_order = {
#     'photo.bmp': 1, 'logo.bmp': 2,
#     'users1.xml': 1, 'input.xml': 2, 'users2.xml': 3, 'config.xml': 4,
#     'data.rar': 1, 'books.rar': 2, 'info.rar': 3,
#     'new_text.txt': 1, 'smth.txt': 2, 'log.txt': 3
# }

# def search_files(extension):
#     matches = []
#     for root, dirs, files in os.walk('.'):  
#         for file in files:
#             if file.endswith(extension):
#                 matches.append(os.path.basename(file)) 
    
#     # Sort based on custom predefined order
#     return sorted(matches, key=lambda x: custom_order.get(x, float('inf')))