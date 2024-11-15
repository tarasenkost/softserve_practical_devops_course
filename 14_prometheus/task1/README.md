# Task on the topic Prometheus

The main task is to configure **Prometheus** to monitor and collect data from the application. In this case, we will use the application located at `/app/SimpleApp-1.0-SNAPSHOT.jar` written in **Java 17**.

Configure **Prometheus** following these requirements:

1. The application located on port `8080`
2. Set the job name as `My app`
3. Define the HTTP resource path as `/actuator/prometheus`
4. The **Prometheus** scrapes metrics from the application every 7 seconds
5. Include the basic authorization header on every scrape request with the following username and password
   - Username: `bob@gmail.com`
   - Password: `passBob`

Once you have completed the configuration, save your config file as `prometheus.yml` and place it into the repository.
<br>
P.S. You have access to [Prometheus playground](https://killercoda.com/online-marathon/scenario/Prometheus/Prometheus_task). Otherwise, make sure you have a functional **Prometheus** instance configured.
