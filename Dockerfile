FROM jolielang/jolie:latest


RUN apk update
RUN apk add git
RUN apk add bash
RUN apk add curl


ADD srv-disk-writer.iol .
ADD main.ol .



CMD ["jolie", "main.ol"]