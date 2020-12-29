# Anime-Alert
This notification app displays all shows of the current season. The selected show is added to your watchlist and notifications will be sent whenever a new episode is released. As this app is mainly for personal use, the UI wasn't focused so feel free to fork this repo and customize it to your liking.


## Running for local use
**Update** The api used for this application is no longer heroku but through Vercel serverless functions. Check out their documentation [here](https://vercel.com/docs/serverless-functions/introduction).<br>
<br>
The api used for this application is [here](https://github.com/junqili259/Anime-Alert-serverless) if you wish to use it locally or deploy your own instance(highly recommended). The older api used was deployed through heroku container registry which can be found [here](https://github.com/junqili259/Anime-Alert-api). ~~**Note:** The api is deployed through the heroku free tier so the container "falls asleep within 30 mins of inactivity" so you may not see anything on the seasons view controller until the container wakes up to handle your request.~~


**To modify the app for local use** <br>
<br>
*Anime-Alert/Networks.swift*
```swift
let urlString = "http://127.0.0.1:8000"
```

*Anime-Alert/NotificationManager.swift*
```swift
let urlString = "http://127.0.0.1:8000/statusUpdate?id=\(id)"
```

## App features
+ View all shows airing this season
+ Able to favorite a show to be notified
+ Get notifications on a favorited show when a new episode airs
+ Continue to get notifications on favorited shows until show is finished of removed from favorites
+ Able to remove a show from favorites
+ State when the next episode is airing at what time in favorites
+ Favorited shows can still be viewed while offline
