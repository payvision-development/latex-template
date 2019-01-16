FROM debian:stretch-slim
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
biber \
latexmk \
make \
texlive-full \
&& apt-get install -qy python python-pip \
&& pip install pygments \
&& rm -rf /var/lib/apt/lists/*