#!/usr/bin/env python3

import os

from pathlib import Path

VARIABLES = [var for var in os.environ if 'ZK' in var and var != 'ZK_DIR']
ZK_DIR = os.environ.get('ZK_DIR')
CONF_FILE = Path(ZK_DIR) / 'conf/zoo.cfg'

if not CONF_FILE.exists():
    with open(CONF_FILE, 'a+') as fp:
        for var_key in VARIABLES:
            var_value = os.environ.get(var_key)
            var_key_parse = var_key.replace('ZK_', '')

            conf_line = f'{var_key_parse}={var_value}'

            fp.write(conf_line + '\n')

            print('Added line', fr'{conf_line}')
else:
    print(f'File {CONF_FILE} exists.')