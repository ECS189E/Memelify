import time
from logging import getLogger
from memelify.api.memes import bot

LOG = getLogger(__name__)

def get_memes():
    global bot
    t = time.time()
    LOG.info('Looking for new meme....')
    bot.refresh()
    LOG.info('in {:.2f} secs.'.format(time.time() -t ))
