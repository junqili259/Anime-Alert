# Anime-Alert
Anime alert system that notifies user of new episode in the season


## Run API locally
### Uvicorn
```
cd api
uvicorn main:app
```

### For hot reloads
```
uvicorn main:app --reload
```

### Docker

```
docker build -t myimage .
docker run -d --name mycontainer -p 80:80 myimage
```

### Tools
[Fastapi](https://github.com/tiangolo/fastapi)
