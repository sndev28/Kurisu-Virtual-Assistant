from googleapiclient.discovery import build
import pickle
from datetime import datetime, timedelta


class ScheduleManager:

    def __init__(self, token):
        self.credentials = pickle.load(open(token, 'rb')) #Google credentials
        self.service = build('calendar', 'v3', credentials = self.credentials)


    def retrieveCalendar(self):
        self.calendar = self.service.calendars().get(calendarId='primary').execute()
        return self.calendar


    def retrieveEvents(self):
        self.events = []
        page_token = None

        while True:
            events = self.service.events().list(calendarId='primary', pageToken=page_token).execute()
            for event in events['items']:
                self.events.append(event)
            page_token = events.get('nextPageToken')
            if not page_token:
                break


    def retrieveSimpleEvents(self, criterion):

        if criterion == None:
            criterion = 'today'


        self.retrieveEvents()

        current = datetime.today()
        today = datetime(current.year, current.month, current.day)

        nextday = datetime.now()+timedelta(1)
        tomorrow = datetime(nextday.year, nextday.month, nextday.day)

        work = []

        def addToWork(event):
            simplifiedEvent = {}

            try:
                simplifiedEvent['id'] =  event['id']
            except:
                pass

            try:
                simplifiedEvent['summary'] =  event['summary']
            except:
                pass

            try:
                simplifiedEvent['description'] = event['description']
            except:
                pass

            try:
                simplifiedEvent['start'] = event['start']
            except:
                pass

            try:
                simplifiedEvent['end'] = event['end']
            except:
                pass

            return simplifiedEvent

        if criterion == 'today':
            for event in self.events:
                try:
                    eventTime = datetime.strptime(event['start']['dateTime'][:-6], '%Y-%m-%dT%H:%M:%S')
                except KeyError:
                    try:
                        eventTime = datetime.strptime(event['start']['date'], '%Y-%m-%d')
                    except Exception as error:
                        print(error)
                except Exception as error:
                    print(error)

                if(eventTime >= today and eventTime < tomorrow):
                    work.append(addToWork(event))

        elif criterion == 'upcoming':
            for event in self.events:
                try:
                    eventTime = datetime.strptime(event['start']['dateTime'][:-6], '%Y-%m-%dT%H:%M:%S')
                except KeyError:
                    try:
                        eventTime = datetime.strptime(event['start']['date'], '%Y-%m-%d')
                    except Exception as error:
                        print(error)
                except Exception as error:
                    print(error)
                if(eventTime >= today):
                    work.append(addToWork(event))

        else:
            for event in self.events:
                work.append(addToWork(event))

        return work


    def addEvent(self, summary, description, eventStartTime, eventEndTime, utcoffset):

        # parsedStartDateTime = eventStartTime.strftime('%Y-%m-%dT%H:%M:%S') + utcoffset
        # parsedEndDateTime = eventEndTime.strftime('%Y-%m-%dT%H:%M:%S') + utcoffset
        parsedStartDateTime = eventStartTime + utcoffset
        parsedEndDateTime = eventEndTime + utcoffset

        newEvent = {
                'summary': summary,
                'description': description,
                'start': {
                    'dateTime': parsedStartDateTime,
                },
                'end': {
                    'dateTime': parsedEndDateTime,
                },                
            }

        event = self.service.events().insert(calendarId='primary', body=newEvent).execute()


    def deleteEvent(self, eventID):
        self.service.events().delete(calendarId='primary', eventId=eventID).execute()


if __name__ == '__main__':
    token = '../resources/token.pkl'
    manager = ScheduleManager(token)
    events = manager.retrieveSimpleEvents(criterion='all')
    for event in events:
        print(event)
    print(len(events))

    # current = datetime.today()
    # today = datetime(current.year, current.month, current.day)

    # nextday = datetime.now()+timedelta(1)
    # tomorrow = datetime(nextday.year, nextday.month, nextday.day)

    # manager.addEvent('test1', 'this is a test', current, tomorrow, '+05:30')



       
    



