FROM ebrown/git:latest as built_git
FROM ebrown/python:3.11 as prod

COPY --from=built_git /opt/git /opt/git
ENV PATH=/opt/git/bin:/opt/python/py311/bin:${PATH}
ENV LD_LIBRARY_PATH=/opt/git/lib:/opt/python/py311/lib:${LD_LIBRARY_PATH}
WORKDIR /tmp
COPY installmkl.sh ./
RUN ./installmkl.sh