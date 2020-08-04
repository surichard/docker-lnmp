###########################
# version kyan/centos_lnmp:1.0
# version Richard/centos_lnmp:1.1
# description: centos上安装LNMP.org一键安装包,包含了源码整包，https://lnmp.org/auto.html无人值守安装
###########################
ARG CENTOS_VERSION
FROM centos:${CENTOS_VERSION}

RUN echo "~~~开始安装依赖~~~" \
    && yum install -y wget \
    && echo "~~~获取lnmp.org  1.7安装包~~~" \
    && wget http://soft.vpszt.com/lnmp/lnmp1.7-full.tar.gz -cO lnmp1.7-full.tar.gz \
    && tar zxf /tmp/lnmp1.7.tar.gz -C /home \
    && cd /home/lnmp1.7-full \    
    && echo "~~~喝杯咖啡稍等片刻...开始安装lnmp.org包~~~" \
    && echo "~~~设置安装参数：数据库Mysql5.7，PHP版本5.6，内存分配器不安装~~~" \
    # 设置无人值守安装参数：Mysql5.7，php安装版本5.6 开始安装
    && LNMP_Auto="y" DBSelect="10" DB_Root_Password="P@sswd3421903490" InstallInnodb="y" PHPSelect="5" SelectMalloc="1" CheckMirror="n" ./install.sh lnmp \
    && echo "~~~清理下载包~~~" \
    && rm -rf /tmp/lnmp1.7-full.tar.gz \
    && yum clean all

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh \
    && chmod 755 usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80
