#!/usr/bin/python

import re
import sys
from subprocess import call,check_output
# from subprocess import check_output

sourceNumber = ''
# sys.argv[1]
sourcesStatus = []
muteOutput = check_output(['pactl', 'list', 'sources']).decode("utf-8").split('\n')
for ind, line in enumerate(muteOutput):
    if re.search('Description: C-Media USB Audio Device', line):
        sourceNumber = re.findall("\d+", muteOutput[ind - 3])[0]
        # print(sourceNumber)
        call(["pactl", "set-source-mute", sourceNumber, "toggle"])
        break

for ind, line in enumerate(muteOutput):
    if re.search('Description: C-Media USB Audio Device', line):
    # if re.search('Source #' + sourceNumber, line):
        if re.search('Mute: no', muteOutput[ind + 5]):
            # call(["notify-send", "❌❌❌"])
            print('0')
            break
            # sourcesStatus.append('0')
        if re.search('Mute: yes', muteOutput[ind + 5]):
        # if re.search('Mute: yes', line + 8):
            # call(["notify-send", "🔴"])
            print('1')
            break
            # sourcesStatus.append('1')
    # break

# if sourcesStatus[1] == '0':
#     print('0')
#     call(["notify-send", "ON"])
# else:
#     call(["notify-send", "OFF"])
#     print('1')
