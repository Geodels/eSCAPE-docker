# eSCAPE-docker

eSCAPE Docker Container with all Dependencies

https://hub.docker.com/u/geodels/


### Local installation

*Python 2 version:*

```
docker build -t geodels/escape-docker:latest -f Dockerfile .
```

*Python 3 version:*
```
docker build -t geodels/escape-docker:python3 -f Dockerfile-python3 .
```

### Pushing the containers registry

```
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
```

```
docker push geodels/escape-docker:latest
docker push geodels/escape-docker:python3
```
