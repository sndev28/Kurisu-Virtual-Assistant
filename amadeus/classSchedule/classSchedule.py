import pickle


class ClassSchedule:
    def __init__(self,SCHEDULE_DATABASE):
        self.timetable = pickle.load(open(SCHEDULE_DATABASE, 'rb'))


    def addClass(self, day, subject, startTime, endTime, link):
        self.timetable[day].append({'subject' : subject, 'startTime' : startTime, 'endTime' : endTime, 'link' : link})
        pickle.dump(self.timetable, open('schedule.pkl', 'wb'))


    def deleteClass(self, day, subject, startTime):
        flag = False
        for item in self.timetable[day]:
            if item.subject == subject and item.startTime == startTime:
                self.timetable[day].remove(item)
                flag = True

        if flag == True:
            pickle.dump(self.timetable, open('schedule.pkl', 'wb'))
        

    def retrieveSchedule(self, day):
        return self.timetable[day]

    def retrieveTimetable(self):
        return self.timetable

