FROM alpine

ENV TERM=linux
WORKDIR /app

RUN apk --no-cache add ruby ruby-etc
RUN echo 'gem: --no-document' > /etc/gemrc && \
    gem install rack rackup puma

COPY config.ru ./

ENV PS1 "\n\n>> redirector \W \$ "
EXPOSE 3000
CMD rackup -p 3000 -o 0.0.0.0
