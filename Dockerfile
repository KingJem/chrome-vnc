FROM ubuntu:22.04

# 环境变量配置（保持原样）
ENV	VNC_PASS="CHANGE_IT" \
	VNC_TITLE="Chromium" \
	VNC_RESOLUTION="1280x720" \
	VNC_SHARED=false \
	DISPLAY=:0 \
	NOVNC_PORT=8080 \
	NO_SLEEP=false \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	TZ="Asia/Kolkata"
ENV DEBIAN_FRONTEND=noninteractive

# 先复制配置文件，利用Docker缓存
COPY assets/ /
COPY chromium-browser-unstable_120.0.6099.312-1_amd64.deb /

# 合并所有RUN指令，减少镜像层数并清理缓存
RUN useradd -ms /bin/bash chrome && \
    apt update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        fonts-liberation \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libatspi2.0-0 \
        libcairo2 \
        libcups2 \
        libcurl4 \
        libdbus-1-3 \
        libdrm2 \
        libexpat1 \
        libgbm1 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libu2f-udev \
        libvulkan1 \
        libx11-6 \
        libxcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxkbcommon0 \
        libxrandr2 \
        wget \
        xdg-utils \
        openssl \
        supervisor \
        cpufrequtils \
        tzdata \
        curl \
        sed \
        unzip \
        xvfb \
        x11vnc \
        websockify \
        openbox \
        fonts-noto-core \
        fonts-noto-cjk && \
    dpkg -i chromium-browser-unstable_120.0.6099.312-1_amd64.deb && \
    openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 \
        -subj "/C=IN/O=Dis/CN=www.google.com" \
        -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1 && \
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone && \
    rm chromium-browser-unstable_120.0.6099.312-1_amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER chrome
ENTRYPOINT ["supervisord", "-l", "/var/log/supervisord.log", "-c"]
CMD ["/config/supervisord.conf"]