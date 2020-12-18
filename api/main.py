from typing import Optional
from fastapi import FastAPI, HTTPException
from datetime import datetime
from seasons import months, month_to_season
import requests

# Dev
import json
import pandas


app = FastAPI()

url = "https://graphql.anilist.co"


@app.get("/")
def currentSeason(page: Optional[int] = 1):

    # Automatically get the current season by month (WINTER, SPRING, SUMMER, FALL)
    current_month = int(datetime.today().strftime("%m"))
    month = months[current_month]
    season_now = month_to_season[month]

    year = int(datetime.today().strftime("%Y"))

    # Prevents displaying previous Winter seasonal shows due to year difference
    if month == "Dec":
        year = year + 1

    query = """query($season: MediaSeason, $seasonYear: Int, $page: Int) {
        Page(page: $page) {
            pageInfo {
                total
                perPage
                currentPage
                lastPage
                hasNextPage
            }
            media(season: $season, seasonYear: $seasonYear, type: ANIME){
                id
                title {
                    romaji
                    english
                }
                coverImage {
                    medium
                    large
                    extraLarge
                }
                episodes
                status
                nextAiringEpisode {
                    airingAt
                    timeUntilAiring
                    episode
                }
            }
        }
    }"""

    variables = {
        "season": season_now,
        "seasonYear": year,
        "page": page
    }

    try:
        response = requests.post(url, json= {"query": query, "variables": variables})
    except requests.exceptions.ConnectionError as error:
        print("A Connection Error occured", error)


    # For displaying data through pandas for dev
    #########
    # json_data = json.loads(response.text)
    # seasonal_anime = json_data["data"]["Page"]["media"]
    # df = pandas.DataFrame(seasonal_anime)
    # print(df)
    ########
    
    # return seasonal_anime
    return response.json()



@app.get("/season")
def anySeason(season: str, seasonYear: int, page: Optional[int] = 1):

    seasons = ['WINTER', 'SPRING', 'SUMMER', 'FALL']

    if season not in seasons:
        raise HTTPException(status_code= 400, detail= "Season syntax error. Example seasons: WINTER, SPRING, SUMMER, FALL")

    query = """query($season: MediaSeason, $seasonYear: Int, $page: Int) {
        Page(page: $page) {
            pageInfo {
                total
                perPage
                currentPage
                lastPage
                hasNextPage
            }
            media(season: $season, seasonYear: $seasonYear, type: ANIME){
                id
                title {
                    romaji
                    english
                }
                coverImage {
                    medium
                    large
                    extraLarge
                }
                episodes
            }
        }
    }"""

    variables = {
        "season": season,
        "seasonYear": seasonYear,
        "page": page
    }

    try:
        response = requests.post(url, json= {"query": query, "variables": variables})
    except requests.exceptions.ConnectionError as error:
        print("A Connection Error occured", error)

    return response.json()
