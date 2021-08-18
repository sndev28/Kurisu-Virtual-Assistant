import requests
from datetime import datetime
import webbrowser as wb
import tkinter
from tkinter import messagebox
import psutil

weekdays = {
    0 : 'monday',
    1 : 'tuesday',
    2 : 'wednesday',
    3 : 'thursday',
    4 : 'friday',
    5 : 'saturday',
    6 : 'sunday'
}

def getSchedule(day, URL):
    print('Getting schedules for the day!')
    BASE_URL = URL + 'classSchedule'
    response = requests.put(BASE_URL, data = {'day': day})

    return response.json()[day]

def killZoom():
    for proc in psutil.process_iter():
        if 'Zoom' in proc.name():
            proc.kill()


def ClassScheduler(URL, autoMode = False):

    parent = tkinter.Tk()
    parent.overrideredirect(1)
    parent.withdraw()
    
    REFRESH_TIME = 5 * 60 #  min * secs // refresh time in seconds

    classInProgress = None

    while True:
        day = weekdays[int(datetime.now().weekday())]

        schedules = getSchedule(day, URL)

        currentTime = datetime.now()


        if classInProgress != None:

            endHour, endMin = classInProgress['endTime'].split(':')

            endTime = datetime(
                    year = currentTime.year,
                    month = currentTime.month,
                    day = currentTime.day,
                    hour = int(endHour),
                    minute = int(endMin)
                ) 

            if currentTime > endTime:
                if autoMode == False:
                    response = messagebox.askokcancel('Kurisu', 'Do you want to close the current class?', parent=parent)
                    if response == True:
                        killZoom()
                    
                else:
                    killZoom()

                classInProgress = None


            

        for _class in schedules:
            startHour, startMin = _class['startTime'].split(':')
            endHour, endMin = _class['endTime'].split(':')

            startTime = datetime(
                year = currentTime.year,
                month = currentTime.month,
                day = currentTime.day,
                hour = int(startHour),
                minute = int(startMin)
            )
            
            

            if currentTime >= startTime and currentTime < endTime:
                if classInProgress != _class:
                    classInProgress = _class
                    if classInProgress != None:
                        killZoom()

                    wb.open(_class['link'])                    
                    break

        
            
            





