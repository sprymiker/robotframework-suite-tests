FROM python:3

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y python3-pip

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x ./robot.sh

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
