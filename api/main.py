from typing import Optional
from fastapi import FastAPI
import requests
import uvicorn

# Dev 
import json
import pandas


app = FastAPI()


@app.get("/")
def current_Season(page: Optional[int] = 1):

    query= """query($season: MediaSeason, $seasonYear: Int, $page: Int) {
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
        "season": "FALL",
        "seasonYear": 2020,
        "page": page
    }

    url = "https://graphql.anilist.co"
    response = requests.post(url= url, json= {"query": query, "variables": variables})

    # For displaying data through pandas for dev
    #########
    #json_data = json.loads(response.text)
    #seasonal_anime = json_data["data"]["Page"]["media"]
    #df = pandas.DataFrame(seasonal_anime)
    #print(df)
    ########
    
    #return seasonal_anime
    return response.json()


"""
@app.get("/season")
def any_Season(season: str, seasonYear: int, page: Optional[int] = 1):
    return
"""