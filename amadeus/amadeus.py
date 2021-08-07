from flask import Flask, request
from flask_restful import Api, Resource, reqparse, abort
from flask_cors import CORS


#Modules

from animeTracker.animeTracker import AnimeTracker, Anime
from scheduleManager.scheduleManager import ScheduleManager

GOOGLE_AUTH_TOKEN = 'resources/token.pkl'
ANIME_DATABASE = 'resources/animeRepo.pkl'

schedule_manager = ScheduleManager(GOOGLE_AUTH_TOKEN)
anime_tracker = AnimeTracker(ANIME_DATABASE)


#Setup

app = Flask(__name__)
CORS(app)
api = Api(app)


#API

scheduleManagerArgs = reqparse.RequestParser()
scheduleManagerArgs.add_argument('criterion', type = str, help = 'Crtierion not sent')
scheduleManagerArgs.add_argument('summary', type = str, help = 'summary not sent')
scheduleManagerArgs.add_argument('description', type = str, help = 'description not sent')
scheduleManagerArgs.add_argument('eventStartTime', type = str, help = 'eventStartTime not sent')
scheduleManagerArgs.add_argument('eventEndTime', type = str, help = 'eventEndTime not sent')
scheduleManagerArgs.add_argument('utcoffset', type = str, help = 'utcoffset not sent')
scheduleManagerArgs.add_argument('id', type = str, help = 'Event id not sent')


class ScheduleManagerAPI(Resource):

    #Commented api requests are working but not implemented. To be implemented once an authorization system has been setup

    def get(self): #Receieve calendar
        return {'calendar': schedule_manager.retrieveCalendar()}, 200
        

    def post(self): #Recieve events
        args = scheduleManagerArgs.parse_args()
        listOfEvents = schedule_manager.retrieveSimpleEvents(criterion = args.get('criterion'))
        return {'events' : listOfEvents}, 200

    def options(self):
        print('Options handled!')
        return 200

    def put(self):
        args = scheduleManagerArgs.parse_args()

        if args.get('summary') == None or args.get('description') == None or args.get('eventStartTime') == None or args.get('eventEndTime') == None or args.get('utcoffset') == None:
            abort(422, 'Not enough data!')

        try:
            schedule_manager.addEvent(args.get('summary'), args.get('description'), args.get('eventStartTime'), args.get('eventEndTime'), args.get('utcoffset'))
        except Exception as e:
            print(e)
            abort(409, message = 'Error in given data!')
        
        return 200

    def delete(self):
        args = scheduleManagerArgs.parse_args()

        if args.get('id') == None:
            abort(422, 'Event id not provided!')

        try:
            schedule_manager.deleteEvent(args.get('id'))
        except:
            abort(409, message = 'Error in given data!')      

        return 200
        

        

api.add_resource(ScheduleManagerAPI, '/schedules')




animeTrackerArgs = reqparse.RequestParser()
animeTrackerArgs.add_argument('id', type = str, help = 'No ID sent!')
animeTrackerArgs.add_argument('name', type = str, help = 'No name sent!')
animeTrackerArgs.add_argument('posterLink', type = str, help = 'No poster link sent!')
animeTrackerArgs.add_argument('searchQuery', type = str, help = 'Search query not sent!')



class AnimeTrackerAPI(Resource):

    def get(self): #Recently aired episodes
        try:
            if request.headers.get('criterion') == 'recentAired':
                return {'recentAired': anime_tracker.track()}, 200
            else:
                return {'tracking': anime_tracker.allTracking()}, 200
        except Exception as e:
            print(e)
            abort(404, message = 'Error retrieving recently aired! Contact developer!')

    def post(self): #New additions
        args = animeTrackerArgs.parse_args()
        
        if args.get('name') == None or args.get('posterLink') == None or args.get('id') == None:
            abort(404, 'Not enough information! Please send id, name and posterlink!')

        try:
            anime_tracker.new(args.get('id'), args.get('name'), args.get('posterLink'))
        except Exception as e:
            print(e)
            abort(409, message = 'Error in given data!')

        return 200

    def delete(self): #delete tracking anime
        args = animeTrackerArgs.parse_args()
        
        if args.get('id') == None:
            abort(404, 'Not enough information! Please send id!')
        
        try:
            anime_tracker.remove(args.get('id'))
        except Exception as e:
            print(e)
            abort(409, message = 'Error in given data!')

        return 200

    def put(self):
        args = animeTrackerArgs.parse_args()
        
        if args.get('searchQuery') == None:
            abort(404, 'Not enough information! Please send search query!')
        
        try:
            queryResult = anime_tracker.search(args.get('searchQuery'))
        except Exception as e:
            print(e)
            abort(409, message = 'Error in given data!')

        return {'queryResult':queryResult}, 200



api.add_resource(AnimeTrackerAPI, '/animetracker')

        

        









if __name__ == '__main__':
    app.run(debug = True, host = '0.0.0.0')


