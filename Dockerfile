FROM python:3.10-bullseye
## naxreo/nginx:flask

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY app /app
WORKDIR /app

# in the WORKERDIR
RUN pip install --no-cache-dir -r requirements.txt

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    useradd -r -s /sbin/nologin nginx && \
    rm -f /etc/nginx/sites-enabled/default

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443 5000
# Run Gunicorn
# flask application must be app.py
ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0 --workers=8 --reload"
CMD gunicorn -b unix:/tmp/gunicorn.sock app:app & nginx -g 'daemon off;'
