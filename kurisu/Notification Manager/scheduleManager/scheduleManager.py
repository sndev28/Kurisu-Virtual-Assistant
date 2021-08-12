import requests
from datetime import datetime
import time

def getEvents(URL):
    print('Getting events!')
    BASE_URL = URL + 'schedules'
    response = requests.post(BASE_URL, data = {'criterion':'today'})
    if response.status_code == 200:
        return response.json()['events']

def ScheduleManager(toast, URL):

    REFRESH_TIME = 5 * 60 # min * sec refresh time in seconds

    checkedTime = datetime.now()
    events = getEvents(URL)

    print('Schedule Manager ready!')

    while True:
        currentTime = datetime.now()

        if currentTime.hour == 0 and currentTime.min <= 6:
            events = getEvents(URL)

        timePassed = currentTime - checkedTime
        if timePassed.seconds >= REFRESH_TIME:
            events = getEvents(URL)
            checkedTime = datetime.now()

        notifiedEvents = []
        notificationMessage = 'Event reminders : \n'
        newNotifications = False

        for event in events:
            try:
                eventStartTime = datetime.strptime(event['start']['dateTime'][:-6], '%Y-%m-%dT%H:%M:%S')
                eventEndTime = datetime.strptime(event['end']['dateTime'][:-6], '%Y-%m-%dT%H:%M:%S')

            except KeyError:
                try:
                    eventStartTime = datetime.strptime(event['start']['date'], '%Y-%m-%d')                   
                    eventEndTime = datetime.strptime(event['end']['date'], '%Y-%m-%d')
                except Exception as error:
                    print(error)
            except Exception as error:
                print(error)
                continue
            
            if datetime.now() >= eventStartTime and datetime.now() <= eventEndTime:
                if event['summary'] not in notifiedEvents:
                    newNotifications = True
                    notifiedEvents.append(event['summary'])
                    notificationMessage += '• ' + event['summary'] + '\n'

        
        if newNotifications:
            toast.show_toast(title = 'Kurisu', msg = notificationMessage, duration = 10)
            newNotifications = False

        time.sleep(59)







            
        



        







