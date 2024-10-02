# The JSON string and xml string will contain information about books, including their title, author, and publication year.
# Extract the information and store it in a list of dictionaries, where each dictionary represents a book.

# {'title': 'Pride and Prejudice', 'author': 'Jane Austen', 'year': 1813}
# {'title': 'Moby-Dick', 'author': 'Herman Melville', 'year': 1851}
# {'title': 'Little Women', 'author': 'Louisa May Alcott', 'year': 1868}
# {'title': 'The Great Gatsby', 'author': 'F. Scott Fitzgerald', 'year': 1925}
# {'title': 'To Kill a Mockingbird', 'author': 'Harper Lee', 'year': 1960}

import json
import xml.etree.ElementTree as ET	

json_string = '[ { "title": "Pride and Prejudice",    "author": "Jane Austen",    "year": 1813  },  {    "title": "Moby-Dick",    "author": "Herman Melville",    "year": 1851  },  {    "title": "Little Women",    "author": "Louisa May Alcott",    "year": 1868  }]'
xml_string = '<books><book><title>The Great Gatsby</title><author>F. Scott Fitzgerald</author><year>1925</year></book><book><title>To Kill a Mockingbird</title><author>Harper Lee</author><year>1960</year></book></books>'


def parse_books(json_string,xml_string):
  book_list = []
  if json_string:
    json_data = json.loads(json_string)
    for obj in json_data:
      book_list.append(obj)
  if xml_string:
    root = ET.fromstring(xml_string)
    for book in root.findall('book'):
      title = book.find('title').text
      author = book.find('author').text
      year = int(book.find('year').text)
      book_list.append({'title':title, 'author':author,'year':year})
  return book_list
        
books = parse_books(json_string,xml_string)
for book in books:
  print(book)