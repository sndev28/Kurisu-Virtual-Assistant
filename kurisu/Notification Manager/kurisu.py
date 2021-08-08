import requests
import time
import threading
from win10toast import ToastNotifier

from animeTracker.animeTracker import AnimeTracker

toast = ToastNotifier()

BASE_URL = 'http://192.168.1.35:5000/'







if __name__ == '__main__':
    
    animeLoop = threading.Thread(target=AnimeTracker, args=(toast,))
    animeLoop.setDaemon(True)
    animeLoop.start()
