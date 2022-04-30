config.load_autoconfig()

config.source('themes/nord.py')

config.unbind('d', mode='normal')
config.unbind('u', mode='normal')

config.bind('x', 'tab-close')
config.bind('X', 'undo')

config.bind('j', 'scroll-px 0 100')
config.bind('k', 'scroll-px 0 -100')

config.bind('d', 'scroll-px 0 500')
config.bind('u', 'scroll-px 0 -500')
