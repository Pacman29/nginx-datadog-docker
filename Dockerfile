
FROM ubuntu:latest

RUN  apt-get update
RUN	apt-get install -y nginx 
RUN	apt-get install -y apt-transport-https 
RUN	sh -c "echo 'deb https://apt.datadoghq.com/ stable main' > /etc/apt/sources.list.d/datadog.list"
RUN	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 C7A7DA52
RUN	apt-get update 
RUN	apt-get install -y datadog-agent
RUN	sh -c "sed 's/api_key:.*/api_key: 29f39d08fcc40afa9a65ffee4f6615cb/' /etc/dd-agent/datadog.conf.example > /etc/dd-agent/datadog.conf"

ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx.yaml /etc/dd-agent/conf.d

CMD /etc/init.d/datadog-agent start && nginx -g 'daemon off;'