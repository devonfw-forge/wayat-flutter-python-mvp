import os
import sys

if not os.path.exists('./lib'): 
    print("Lib directory not found in the current path")
    sys.exit()
for base, dirs, files in os.walk('.'):
    for file in files:
        if file.endswith('.g.dart') \
            or file.endswith('.gr.dart') \
            or file.endswith('.mocks.dart'):
            print("Removing: {}".format(os.path.join(base, file)))
            os.remove(os.path.join(base, file))