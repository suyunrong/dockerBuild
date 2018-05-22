FROM centos:6.9
LABEL authors=suyunrong

#=======================================
# Set Coding
#=======================================
ENV LANG C.UTF-8

#=======================================
# Install base package
#=======================================
RUN yum install update -y \
  && yum install curl \
    unzip \
    tzdata \
    openssh-server \
  && rm -rf /tmp/* \
  && yum clean all

#=======================================
# Set timezone
#=======================================
ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/TZ

#=======================================
# Install sshd
#=======================================
RUN mkdir /var/run/sshd \
  && mkdir /root/.ssh \
  && echo 'root:123456' |chpasswd \
  && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#========================================
# Tomcat config
# http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.0.51/bin/apache-tomcat-8.0.51.tar.gz
#========================================
ENV VERSION "v7.0.88"
ENV TOMCAT_VERSION "apache-tomcat-7.0.88"
RUN curl -o /tmp/$TOMCAT_VERSION.tar.gz http://mirrors.hust.edu.cn/apache/tomcat/tomcat-7/$VERSION/bin/$TOMCAT_VERSION.tar.gz \
 && mkdir -p /www/tomcat/ \
 && tar -xzvf /tmp/$TOMCAT_VERSION.tar.gz -C /www/tomcat/ \
 && rm -rf /www/tomcat/$TOMCAT_VERSION/webapps/* \
 && rm -rf /tmp/$TOMCAT_VERSION.tar.gz

EXPOSE 22 8080

CMD ["/bin/bash"]