import pickle
import feedparser
import json
import requests
from bs4 import BeautifulSoup




class Anime:
    def __init__(self, name, posterLink, id):
        self.name = name
        self.posterLink = posterLink
        self.id = id

    def toJSON(self):
        return {'id' : self.id, 'name' : self.name, 'posterLink' : self.posterLink}


class AnimeTracker:
    def __init__(self, ANIME_DATABASE):
        self.ANIME_DATABASE = ANIME_DATABASE
        self.animeRepo = pickle.load(open(ANIME_DATABASE, 'rb'))
        self.feed_url = 'https://www.livechart.me/feeds/episodes'
        self.imageBaseLink = 'https://cdn.myanimelist.net/images/anime/'
        self.baseLink = 'https://myanimelist.net/anime.php?cat=anime&q='

    
    def allTracking(self):
        return [anime.toJSON() for anime in self.animeRepo]


    def new(self, id, name, posterLink):
        newEntry = Anime(id, name, posterLink)
        self.animeRepo.append(newEntry)
        pickle.dump(self.animeRepo, open(self.ANIME_DATABASE, 'wb'))


    def remove(self, id):
        for anime in self.animeRepo:
            if anime.id == id:
                self.animeRepo.remove(anime)
                pickle.dump(self.animeRepo, open(self.ANIME_DATABASE, 'wb'))
                break
        

    def track(self):
        feed = feedparser.parse(self.feed_url)
        recentAired = []

        for entry in feed.entries:
            for anime in self.animeRepo:
                if anime.name in entry.title:
                    recentAired.append(anime.toJSON())

        return recentAired
        

    def search(self, searchQuery):
        searchQuery = searchQuery.replace(' ', '+')
        searchQueryLink = self.baseLink + searchQuery

        query = requests.get(searchQueryLink)

        page = BeautifulSoup(query.text, 'lxml')

        table = page.find_all('table')[-1]

        queryResult = []
        
        try:
            searchResults = table.find_all('tr')[1:]        
            
            if len(searchResults) > 11:
                searchResults = searchResults[:10]           

            for searchResult in searchResults:
                name = searchResult.find('strong').text
                try:
                    posterLink = searchResult.find('img')['data-srcset']
                    linkParts = posterLink.split('anime/')
                    finalLink = self.imageBaseLink + linkParts[1].split('?')[0]
                except:
                    posterLink = 'Not Available'            

                queryResult.append({'name':name,'posterLink':finalLink})

        except:
            return []


        return queryResult







        

        
    

if __name__ == '__main__':
    tracker = AnimeTracker()
    # tracker.new('Mairimashita! Iruma-kun 2nd Season', 'meh')
    # print(tracker.track())
    # print(type(tracker.track()))

    # while(True):
    query = 'bokutachi'
    print(tracker.search(query))


    # print(tracker.animeRepo)
