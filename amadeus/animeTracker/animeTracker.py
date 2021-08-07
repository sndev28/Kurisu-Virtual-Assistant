import pickle
import feedparser
import json
import requests
from bs4 import BeautifulSoup

baseLink = 'https://myanimelist.net/anime.php?cat=anime&q='
imageBaseLink = 'https://cdn.myanimelist.net/images/anime/'


class Anime:
    def __init__(self, name, posterLink):
        self.name = name
        self.posterLink = posterLink

    def toJSON(self):
        return {'name' : self.name, 'posterLink' : self.posterLink}


class AnimeTracker:
    def __init__(self):
        self.animeRepo = pickle.load(open('animeRepo.pkl', 'rb'))
        self.feed_url = 'https://www.livechart.me/feeds/episodes'

    def new(self, name, posterLink):
        newEntry = Anime(name, posterLink)
        self.animeRepo.append(newEntry)
        pickle.dump(self.animeRepo, open('animeRepo.pkl', 'wb'))


    def remove(self, name):
        for anime in self.animeRepo:
            if anime.name == name:
                self.animeRepo.remove(anime)
                pickle.dump(self.animeRepo, open('animeRepo.pkl', 'wb'))
                break
        

    def track(self):
        feed = feedparser.parse(self.feed_url)
        recentAired = []

        for entry in feed.entries:
            for anime in self.animeRepo:
                if anime.name in entry.title:
                    recentAired.append(anime.toJSON())

        return json.dumps({'recentlyAired': recentAired})
        

    def search(self, searchQuery):
        searchQuery = searchQuery.replace(' ', '+')
        searchQueryLink = baseLink + searchQuery

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
                    finalLink = imageBaseLink + linkParts[1].split('?')[0]
                except:
                    posterLink = 'Not Available'            

                queryResult.append({'name':name,'posterLink':finalLink})

        except:
            pass


        return json.dumps({'queryResult':queryResult})







        

        
    

if __name__ == '__main__':
    tracker = AnimeTracker()
    # tracker.new('Mairimashita! Iruma-kun 2nd Season', 'meh')
    # print(tracker.track())
    # print(type(tracker.track()))

    # while(True):
    query = 'bokutachi'
    print(tracker.search(query))


    # print(tracker.animeRepo)
