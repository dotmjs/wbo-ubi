FROM  ubi8/ubi-minimal

WORKDIR /opt/app

ADD --chown=1000:1000 https://codeload.github.com/lovasoa/whitebophir/zip/refs/tags/v1.10.2  /tmp/wbo/wbo.zip  

RUN microdnf install npm unzip && unzip /tmp/wbo/wbo.zip -d /tmp/wbo && cp -a /tmp/wbo/*/. /opt/app && microdnf remove unzip  && chown -R 1000:1000 /opt/app

USER 1000:1000
ENV HOME /opt/app

RUN npm ci --production

ENV PORT=8080
EXPOSE 8080

VOLUME /opt/app/server-data

CMD ["npm", "start"]

