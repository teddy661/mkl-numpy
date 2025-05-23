FROM ebrown/git:latest AS built_git
FROM ebrown/python:3.13 AS prod

COPY --from=built_git /opt/git /opt/git
ENV PATH=/opt/git/bin:/opt/python/py313/bin:${PATH}
ENV LD_LIBRARY_PATH=/opt/git/lib:/opt/python/py313/lib:${LD_LIBRARY_PATH}
WORKDIR /tmp
COPY build-numpy-scipy.sh ./
RUN chmod 700 ./build-numpy-scipy.sh && ./build-numpy-scipy.sh
WORKDIR /root
COPY . .
COPY entrypoint.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
