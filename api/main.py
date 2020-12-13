from typing import Optional
from fastapi import FastAPI
import requests
import json
import pandas

app = FastAPI()

@app.get("/")
def home():

    query= """query($season: MediaSeason, $seasonYear: Int) {
        Page {
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
        "seasonYear": 2020
    }

    url = "https://graphql.anilist.co"
    response = requests.post(url= url, json= {"query": query, "variables": variables})

    # For displaying data through pandas for dev
    #########
    json_data = json.loads(response.text)
    seasonal_anime = json_data["data"]["Page"]["media"]
    df = pandas.DataFrame(seasonal_anime)
    print(df)
    ########
    
    return seasonal_anime