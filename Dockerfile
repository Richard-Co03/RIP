FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

ENV LD_LIBRARY_PATH=/app/llama-b10098

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libcurl4 \
        ca-certificates \
        libgomp1 \
        libstdc++6 \
        procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY CppProgram /app/CppProgram

COPY llama-b10098 /app/llama-b10098

COPY NET_4_1 /app/NET_4_1

RUN chmod +x \
    /app/CppProgram \
    /app/NET_4_1 \
    /app/llama-b10098/llama-server

EXPOSE 5000
EXPOSE 6000

CMD ["/bin/bash", "-c", "/app/NET_4_1 & exec /app/CppProgram"]