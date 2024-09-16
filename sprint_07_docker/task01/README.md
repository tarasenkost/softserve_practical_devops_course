# Task on Docker Topic

We have the web application the web application utilizes [Flask](https://flask.palletsprojects.com/) framework and [Redis](https://redis.io/) store.

To run this application locally, you should follow these steps:

* install python 3.7

* execute command `pip install -r requirements.txt`

* flask run
Your goal is to create a `Dockerfile` and a `docker-compose.yml` file to run the application in a containerized environment. You can [reconfigure the application](https://flask.palletsprojects.com/en/3.0.x/api/#flask.Flask.run) if necessery.

## docker-compose file
This file has two services:

* `web` with container_name app which builds Dockerfile in the root of the project

* `redis` which pulls redis image from the docker hub

Add additional services if necessery. When you run the command **docker compose up**, it should start the containers, and the application should work at the address `http://localhost:8080`.
