FROM nginx:1.22

# install certbot
RUN apt-get update
RUN apt-get install python3 python3-venv libaugeas0 -y
RUN apt-get remove certbot
RUN python3 -m venv /opt/certbot/
RUN /opt/certbot/bin/pip install --upgrade pip
RUN /opt/certbot/bin/pip install certbot certbot-nginx
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot
RUN /opt/certbot/bin/pip install certbot-dns-route53

# use credentials with build args
ARG aws_access_key_id
ARG aws_secret_access_key
ENV AWS_ACCESS_KEY_ID=$aws_access_key_id
ENV AWS_SECRET_ACCESS_KEY=$aws_secret_access_key

# aquire certificate
RUN certbot certonly --dns-route53 -d chomosuke.com -d *.chomosuke.com -m a13323600@gmail.com --agree-tos -n

# setup auto renewal
RUN echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | tee -a /etc/crontab > /dev/null

COPY nginx.conf /etc/nginx/nginx.conf
