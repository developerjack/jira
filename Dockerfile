# jira 的基础镜像版本, 需要更换成自己需求的版本号，适用于升级jira
FROM atlassian/jira-software:8.16.1 AS jira
 
LABEL creator="liyuanhan"
 
USER root
 
# 软件包下载地址: https://github.com/qinyuxin99/atlassian-agent
COPY ./atlassian-agent.jar /opt/atlassian/jira/
 
# jira配置和连接mysql参考文档：https://confluence.atlassian.com/adminjiraserver0816/connecting-jira-applications-to-a-database-1063163980.html
# 添加 mysql 驱动 下载地址： https://downloads.mysql.com/archives/c-j/
COPY ./mysql-connector-java-5.1.48.jar /opt/atlassian/jira/lib/
 
# 使atlassian-agent.jar和Tomcat 一起启动
RUN echo 'export JAVA_OPTS="-javaagent:/opt/atlassian/jira/atlassian-agent.jar ${JAVA_OPTS}"' >> /opt/atlassian/jira/bin/setenv.sh

# ubuntu 系统设置时区 和 24小时
# RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && echo "LC_TIME=en_DK.UTF-8" >/etc/default/locale

# 构建 jira镜像和推送镜像到harbor等镜像仓库
#  docker build -t iocharger/jira:latest . --no-cache
