FROM alpine:3.7


#======================
# 设置字符集
#======================
ENV LANG C.UTF-8

#======================
# 安装基础包
#======================
RUN apk upgrade -U \
  && apk add \
    bash \
    curl \
    tzdata \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/*

#======================
# 设置时区
#======================
ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/TZ

#======================
# 安装openjdk
#======================
RUN apk upgrade -U \
  && apk add \
    openjdk7-jre \
    openjdk8-jre \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/*


CMD ["/bin/bash"]