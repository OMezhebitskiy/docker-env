# 🐳 Docker Dev Environment

A local development environment with multiple PHP versions and services:
- PHP-FPM 8.1, 8.2, 8.4
- Nginx
- MySQL 8.3
- PostgreSQL
- Redis + Redis WebUI
- RabbitMQ
- Buggregator (log aggregator)
- Composer
- Cron

---
## 🚀 Quick Start
1️⃣ **Clone the repository:**

```bash
git clone https://github.com/OMezhebitskiy/docker-env.git
cd repo
```

2️⃣ Set up .env:

Rename example.env to .env file and edit:
```dotenv
PROJECTS_PATH=/Users/username/projects
DOCKER_HOST_IP=host.docker.internal
```

3️⃣ Start the environment:

```bash
docker compose up -d --build
```

4️⃣ Check services:

Nginx: http://sample.localhost/
Redis WebUI: http://localhost:9987/
Buggregator: http://localhost:8000
RabbitMQ: http://localhost:15672 (login/pass: guest/guest)


## 🛠 Adding a New Project (Host)

1️⃣ Place your project in the folder:

```conf
/Users/username/projects/my-new-app
```
2️⃣ Create an Nginx config in nginx/:

```nginx
nginx/my-new-app.conf
```
Example config:

```nginx
server {
    listen 80;
    server_name my-new-app.local;
    root /var/www/my-new-app/public;

    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass php82:9000;  # choose the needed PHP version
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

3️⃣ Add alias in docker-compose.yml:

```yaml
nginx:
  networks:
    appNet:
      aliases:
        - my-new-app.local
```

4️⃣ Add to your host machine’s /etc/hosts:

```text
127.0.0.1 my-new-app.local
```

5️⃣ Restart Nginx (if needed):

```bash
docker compose restart nginx
```


## 📦 Installed PHP Extensions

pdo, pdo_mysql, mysqli, intl, gd, mbstring, zip, exif, pcntl, sockets

imap (only for 8.1 and 8.2, if enabled)

redis (via PECL)

imagick (via PECL)

composer (global)


## 🧠 Notes
On Mac/Windows, host.docker.internal works by default.

On Linux, set the gateway IP (e.g., 172.17.0.1) in .env as DOCKER_HOST_IP.