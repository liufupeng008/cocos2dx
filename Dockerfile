FROM faultyolive/cocos2d-x

WORKDIR /root

COPY start-dev.sh ./
COPY etc/pip.conf /root/.pip/pip.conf
COPY requirements-dev.txt ./
COPY ./etc/apt.sources.list /etc/apt/sources.list
#–privileged 赋予容器最高权限，基本上宿主机能干的事情，容器里都能干。
# unrar 环境变量
ENV UNRAR_LIB_PATH /usr/lib/libunrar.so
ENV TZ Asia/Shanghai
#下载pip
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py
RUN cd ./ && \
    pip install --no-cache-dir -r requirements-dev.txt && rm requirements-dev.txt

VOLUME  /var/code

EXPOSE 8000

ENTRYPOINT ["/bin/bash"]
# ENTRYPOINT 和 CMD的组合用法
CMD ["/root/start-dev.sh"]


