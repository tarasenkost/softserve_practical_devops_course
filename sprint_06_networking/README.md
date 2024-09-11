# Task on the topic UFW

You have been provided with a server (172.168.0.100) on which an application is running, and you need to configure permissions and traffic separation for it. Here are the requirements:

- Access to the database (port 3306) should only be allowed from the server component of the application running on port 3000 of this server.
- The application has an admin panel on port 3005, which should be accessible exclusively from the IP address 192.168.32.55. All other addresses should be blocked (i.e., we need to reject connections, as we cannot use the deny command).
- The server management admin panel is on port 8099. Incoming traffic on port 8099 should be allowed from the eth0 interface (assuming eth0 is the name of your network interface).
- The port range from 6050 to 6055 is leased. Set a connection limit for connections to these ports.
- Create a bash script named `add-rules.sh` that automates all described setting. This script should also take the filename as a parameter and export UFW List Rules into the specified file.

Finally, push the `add-rules.sh` file to the GitHub repository.

P.S. You have access to [Networking](https://killercoda.com/online-marathon/course/Networking/Networking_Playground) playground.
