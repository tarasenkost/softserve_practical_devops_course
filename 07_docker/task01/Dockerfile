FROM python:3.7-alpine3.18

RUN adduser -u 1000 -D non-root 

WORKDIR /app

COPY --chown=non-root:non-root requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=non-root:non-root home.py .

EXPOSE 5000

USER non-root:non-root

CMD ["python", "home.py"]
