import requests
import time


def AnimeTracker(toast, URL):
    
    REFRESH_TIME = 12 * 60 * 60 # hours * min * secs // refresh time in seconds

    BASE_URL = URL + 'animetracker'

    print('Anime tracker ready!')

    while True:
        response = requests.get(BASE_URL, headers = {'criterion': 'recentAired'})

        if response.status_code != 200:
            print('Error in anime tracker! Exited!!')
            break

        listOfRecentAired = response.json().get('recentAired')

        if listOfRecentAired != None and listOfRecentAired != []:
            notificationMessage = 'Recently aired : \n'
            for anime in listOfRecentAired:
                notificationMessage += '• ' + anime.get('name') + '\n'

            toast.show_toast(title = 'Kurisu', msg = notificationMessage, duration = 10)


        time.sleep(REFRESH_TIME)

    
    return


    

