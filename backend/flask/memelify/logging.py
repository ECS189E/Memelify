import sys
import logging

class CustomFormatter(logging.Formatter):
    LEVEL_MAP = {
        logging.FATAL: 'F', 
        logging.ERROR: 'E', 
        logging.WARN: 'W', 
        logging.INFO: 'I', 
        logging.DEBUG: 'D'
    }
    def format(self, record):
        record.levelletter = self.LEVEL_MAP[record.levelno]
        return super(CustomFormatter, self).format(record)


def setup_logging(name=None):
    """Setup Google-Style logging for the entire application."""
    log_to_disk = False
    fmt = '%(levelletter)s%(asctime)s.%(msecs).03d %(process)d %(filename)s:%(lineno)d] %(message)s'
    datefmt = '%m%d %H:%M:%S'
    formatter = CustomFormatter(fmt, datefmt)

    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.ERROR if log_to_disk else logging.DEBUG)
    console_handler.setFormatter(formatter)

    root = logging.getLogger()
    root.setLevel(logging.DEBUG)
    root.addHandler(console_handler)