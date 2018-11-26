import time
import datetime
import sys

def wait_task():
    '''sample task that sleeps 5 seconds then returns the current datetime'''
    print('Task is init....',  file=sys.stdout)
    time.sleep(2)
    print(datetime.datetime.now().isoformat())
    print('Task is completed....',  file=sys.stdout)
    # return datetime.datetime.now().isoformat()