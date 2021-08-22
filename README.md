# Kurisu Virtual Assistant

A virtual assistant to manage my schedules and random stuff. Backend written in python and UI in dart.

  
  

### _Features_

  

```

Daily schedule manager in connection with Google Calendar

Anime tracker

Online class launcher

```

  
  
  

### _Agenda_

  

```

Youtube tracker


```

  

### _Nomenclature_

  

| Name | Usage |
| ------ | ------ |
| Amadeus | Server code for the assistant |
| Kurisu | Windows UI client app |
| Christina | Android client app |

  

### _Instructions to setup_

Coming soon...

  

### _Amadeus API Reference_

  

**Schedule Manager**

Endpoint : schedules  

| Method | Response |
| ------ | ------ |
| GET | Retrieves Google Calendar |
| POST | Retrieves events based on criteria.<br>Criteria to be sent in the body under **'criterion'**.<br>**Available criterias** : 'all', 'today', 'upcoming' |
| PUT | Creates new event.<br>**Data to be sent** : 'summary', 'description', 'eventStartTime', 'eventEndTime', 'utcoffset'<br>Note that **eventStartTime** and **eventEndTime** have to be sent in the format 'yyyy-mm-ddThh:mm:ss'(**Note**: The 'T' is a placeholder and is compulsory). **utcoffset** format '+hh:mm'|
| DELETE | Deletes an event using event ID. Data to be sent : 'id' |

  
<br><br>
**Anime Tracker**

Endpoint : animetracker

| Method | Response |
| ------ | ------ |
| GET | Retrieves tracking anime list based on criteria. <br>Criteria to be sent in the body under **'criterion'**.<br>**Available criterias** : 'tracking', 'recentAired'. 'recentAired' returns tracking anime aired in past 24 hours and 'tracking' returns all anime being tracked|
| POST | Adds anime to be tracked.<br>**Data to be sent** : 'id', 'name', 'posterLink' <br>Note that **id** is the ID of the anime returned through PUT or GET|
| PUT | Returns list of anime based on search query.<br>**Data to be sent** : 'searchQuery'|
| DELETE | Deletes an anime being tracked.<br>**Data to be sent** : 'id' <br>Note that **id** is the ID of the anime returned through PUT or GET |
  
  
  

### _License_

  

```

Open to anyone to copy, modify and use as they see fit with proper credits to the coder.

```

  

### _Suggestions or Issues_

  

Use issues to raise any issues and use this [form](https://forms.gle/W6igzbXRw9yV7onc6 "Google Form") to give suggestions on improving/for new features.

  

### _After Notes_

  

Consider following me to get notified of my latest projects. Stay tuned for the exciting stuff to come..!!
