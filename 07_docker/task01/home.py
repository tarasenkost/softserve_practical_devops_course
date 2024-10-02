import os
import time
import redis
from flask import Flask


app = Flask(__name__)

redis_host = os.environ.get('REDIS_HOST', 'redis')
redis_port = int(os.environ.get('REDIS_PORT', 6379))
app_port = int(os.environ.get('APP_PORT', 5000))

cache = redis.Redis(host=redis_host, port=redis_port)


def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)


@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello from root'

@app.route('/db')
def db():
    return f'{cache.info("Server")}'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=app_port)
