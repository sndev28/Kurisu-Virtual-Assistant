import time
import threading
from win10toast import ToastNotifier

from scheduleManager.scheduleManager import ScheduleManager
from animeTracker.animeTracker import AnimeTracker
from classScheduler.classScheduler import ClassScheduler

toast = ToastNotifier()

URL = 'http://192.168.1.35:5000/'



if __name__ == '__main__':


    #Schedule Manager

    scheduleLoop = threading.Thread(target = ScheduleManager, args = (toast, URL))
    scheduleLoop.setDaemon(True)
    scheduleLoop.start()

    #Anime Tracker
    
    animeLoop = threading.Thread(target = AnimeTracker, args = (toast, URL))
    animeLoop.setDaemon(True)
    animeLoop.start()

    #Class Scheduler
    autoMode = input('Do you want to run class scheduler in auto mode...!? y/n')
    if autoMode == 'n':
        autoMode = False
    else:
        autoMode = True
    classScheduleLoop = threading.Thread(target = ClassScheduler, args = (URL, autoMode))
    classScheduleLoop.setDaemon(True)
    classScheduleLoop.start()


    while scheduleLoop.is_alive() and animeLoop.is_alive() and classScheduleLoop.is_alive():
        print('Kurisu runnning!')
        time.sleep(60)
        

    
