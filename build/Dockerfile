FROM ubuntu
MAINTAINER Ravinder <rsthakur@hotmail.com>

WORKDIR /flask-spa

ADD  ./flask-spa /flask-spa
RUN echo `pwd`
RUN echo `ls -l`
RUN apt-get update -y; apt-get install python3-pip python3.6 -y; pip3 install -r requirements.txt

EXPOSE 5000
CMD ["python3", "main.py"] 
