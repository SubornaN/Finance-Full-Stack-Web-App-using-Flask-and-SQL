FROM python:latest

RUN apt update && apt upgrade -y

RUN apt -y install python3-pip

RUN python3 -m pip install --upgrade pip

RUN apt -y install git

RUN apt -y install default-mysql-server

RUN apt -y install default-libmysqlclient-dev

RUN pip3 install flask-mysqldb

RUN git clone https://github.com/SubornaN/Finance-Full-Stack-Web-App-using-Flask-and-SQL.git FinanceApp

WORKDIR /FinanceApp

RUN git switch Development

COPY apikey.txt /FinanceApp

RUN chmod +x apikey.txt

RUN cat apikey.txt > .env

RUN pip install -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=application

ENTRYPOINT flask run --host=0.0.0.0 -p 5000