import pickle
from datetime import time


class ClassSchedule:
    def __init__(self,SCHEDULE_DATABASE):
        self.SCHEDULE_DATABASE = SCHEDULE_DATABASE
        self.timetable = pickle.load(open(SCHEDULE_DATABASE, 'rb'))


    def addClass(self, day, subject, startTime, endTime, link):
        startHour, startMinute = startTime.split(':')
        startTimeObject = time(hour = int(startHour), minute = int(startMinute))
        flag = False
        for index, item in enumerate(self.timetable[day]):
            itemStartHour, itemStartMinute = item['startTime'].split(':')
            itemTimeObject = time(hour = int(itemStartHour), minute = int(itemStartMinute))

            if itemTimeObject > startTimeObject:
                self.timetable[day].insert(index, {'day': day, 'subject' : subject, 'startTime' : startTime, 'endTime' : endTime, 'link' : link})
                flag = True
                break

        if flag == False:
            self.timetable[day].append({'day': day, 'subject' : subject, 'startTime' : startTime, 'endTime' : endTime, 'link' : link})

        
        pickle.dump(self.timetable, open(self.SCHEDULE_DATABASE, 'wb'))


    def deleteClass(self, day, subject, startTime):
        flag = False
        for item in self.timetable[day]:
            if item['subject'] == subject and item['startTime'] == startTime:
                self.timetable[day].remove(item)
                flag = True

        if flag == True:
            pickle.dump(self.timetable, open(self.SCHEDULE_DATABASE, 'wb'))
        

    def retrieveSchedule(self, day):
        return self.timetable[day]

    def retrieveTimetable(self):
        return self.timetable

