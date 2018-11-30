from PIL import Image,ImageFile
import imagehash,os
from collections import OrderedDict

print("検査するディレクトリを指定")
target_path = input(">> ")

filenames = os.listdir(target_path)

phash_list = OrderedDict()
for filename in filenames:
    _, ext = os.path.splitext(filename)
    if ext == '.jpg':
        hash = imagehash.phash(Image.open(f"{target_path}/{filename}"))
        phash_list[hash] = filename
        print(hash)
    
