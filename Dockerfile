
FROM fabric8/s2i-java:latest

MAINTAINER Jens Reimann <jreimann@redhat.com>
LABEL maintainer "Jens Reimann <jreimann@redhat.com>"

USER root

ENV \
 OPENJ9_VERSION=jdk8u162-b12_openj9-0.8.0

RUN \
  curl -L -o /OpenJDK8-OPENJ9_x64_Linux.tar.gz https://github.com/AdoptOpenJDK/openjdk8-openj9-releases/releases/download/${OPENJ9_VERSION}/OpenJDK8-OPENJ9_x64_Linux_${OPENJ9_VERSION}.tar.gz && \
  cd /usr/lib/jvm && \
  tar xzf /OpenJDK8-OPENJ9_x64_Linux.tar.gz && \
  chmod -R a=rw "/usr/lib/jvm/${OPENJ9_VERSION}" && \
  chmod -R a+x "/usr/lib/jvm/${OPENJ9_VERSION}/jre/bin" && \
  chmod -R a+x "/usr/lib/jvm/${OPENJ9_VERSION}/bin" && \
  find "/usr/lib/jvm/${OPENJ9_VERSION}" -type d -exec chmod a+x {} + && \
  rm /OpenJDK8-OPENJ9_x64_Linux.tar.gz

ENV PRIORITY=91800151

RUN alternatives \
  --install /usr/bin/java java /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/java ${PRIORITY} --family java-1.8.0-openj9.x64_86 \
  --slave /usr/lib/jvm/jre jre /usr/lib/jvm/${OPENJ9_VERSION}/jre \
  --slave /usr/bin/jjs jjs /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/jjs \
  --slave /usr/bin/keytool keytool /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/keytool \
  --slave /usr/bin/orbd orbd /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/orbd \
  --slave /usr/bin/pack200 pack200 /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/pack200 \
  --slave /usr/bin/rmid rmid /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/rmid \
  --slave /usr/bin/rmiregistry rmiregistry /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/rmiregistry \
  --slave /usr/bin/servertool servertool /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/servertool \
  --slave /usr/bin/tnameserv tnameserv /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/tnameserv \
  --slave /usr/bin/policytool policytool /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/policytool \
  --slave /usr/bin/unpack200 unpack200 /usr/lib/jvm/${OPENJ9_VERSION}/jre/bin/unpack200 \
  --slave /usr/share/man/man1/java.1 java.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/java.1 \
  --slave /usr/share/man/man1/jjs.1 jjs.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jjs.1 \
  --slave /usr/share/man/man1/keytool.1 keytool.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/keytool.1 \
  --slave /usr/share/man/man1/orbd.1 orbd.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/orbd.1 \
  --slave /usr/share/man/man1/pack200.1 pack200.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/pack200.1 \
  --slave /usr/share/man/man1/rmid.1 rmid.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/rmid.1 \
  --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/rmiregistry.1 \
  --slave /usr/share/man/man1/servertool.1 servertool.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/servertool.1 \
  --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/tnameserv.1 \
  --slave /usr/share/man/man1/policytool.1 policytool.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/policytool.1 \
  --slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/unpack200.1 \
  && \
  alternatives \
  --install /usr/bin/javac javac /usr/lib/jvm/${OPENJ9_VERSION}/bin/javac $PRIORITY  --family java-1.8.0-openj9.x64_86 \
  --slave /usr/lib/jvm/java java_sdk /usr/lib/jvm/${OPENJ9_VERSION} \
  --slave /usr/lib/jvm-exports/java java_sdk_exports /usr/lib/jvm-exports/${OPENJ9_VERSION} \
  --slave /usr/bin/appletviewer appletviewer /usr/lib/jvm/${OPENJ9_VERSION}/bin/appletviewer \
  --slave /usr/bin/extcheck extcheck /usr/lib/jvm/${OPENJ9_VERSION}/bin/extcheck \
  --slave /usr/bin/idlj idlj /usr/lib/jvm/${OPENJ9_VERSION}/bin/idlj \
  --slave /usr/bin/jar jar /usr/lib/jvm/${OPENJ9_VERSION}/bin/jar \
  --slave /usr/bin/jarsigner jarsigner /usr/lib/jvm/${OPENJ9_VERSION}/bin/jarsigner \
  --slave /usr/bin/javadoc javadoc /usr/lib/jvm/${OPENJ9_VERSION}/bin/javadoc \
  --slave /usr/bin/javah javah /usr/lib/jvm/${OPENJ9_VERSION}/bin/javah \
  --slave /usr/bin/javap javap /usr/lib/jvm/${OPENJ9_VERSION}/bin/javap \
  --slave /usr/bin/jcmd jcmd /usr/lib/jvm/${OPENJ9_VERSION}/bin/jcmd \
  --slave /usr/bin/jconsole jconsole /usr/lib/jvm/${OPENJ9_VERSION}/bin/jconsole \
  --slave /usr/bin/jdb jdb /usr/lib/jvm/${OPENJ9_VERSION}/bin/jdb \
  --slave /usr/bin/jdeps jdeps /usr/lib/jvm/${OPENJ9_VERSION}/bin/jdeps \
  --slave /usr/bin/jhat jhat /usr/lib/jvm/${OPENJ9_VERSION}/bin/jhat \
  --slave /usr/bin/jinfo jinfo /usr/lib/jvm/${OPENJ9_VERSION}/bin/jinfo \
  --slave /usr/bin/jmap jmap /usr/lib/jvm/${OPENJ9_VERSION}/bin/jmap \
  --slave /usr/bin/jps jps /usr/lib/jvm/${OPENJ9_VERSION}/bin/jps \
  --slave /usr/bin/jrunscript jrunscript /usr/lib/jvm/${OPENJ9_VERSION}/bin/jrunscript \
  --slave /usr/bin/jsadebugd jsadebugd /usr/lib/jvm/${OPENJ9_VERSION}/bin/jsadebugd \
  --slave /usr/bin/jstack jstack /usr/lib/jvm/${OPENJ9_VERSION}/bin/jstack \
  --slave /usr/bin/jstat jstat /usr/lib/jvm/${OPENJ9_VERSION}/bin/jstat \
  --slave /usr/bin/jstatd jstatd /usr/lib/jvm/${OPENJ9_VERSION}/bin/jstatd \
  --slave /usr/bin/native2ascii native2ascii /usr/lib/jvm/${OPENJ9_VERSION}/bin/native2ascii \
  --slave /usr/bin/rmic rmic /usr/lib/jvm/${OPENJ9_VERSION}/bin/rmic \
  --slave /usr/bin/schemagen schemagen /usr/lib/jvm/${OPENJ9_VERSION}/bin/schemagen \
  --slave /usr/bin/serialver serialver /usr/lib/jvm/${OPENJ9_VERSION}/bin/serialver \
  --slave /usr/bin/wsgen wsgen /usr/lib/jvm/${OPENJ9_VERSION}/bin/wsgen \
  --slave /usr/bin/wsimport wsimport /usr/lib/jvm/${OPENJ9_VERSION}/bin/wsimport \
  --slave /usr/bin/xjc xjc /usr/lib/jvm/${OPENJ9_VERSION}/bin/xjc \
  --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/appletviewer.1 \
  --slave /usr/share/man/man1/extcheck.1 extcheck.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/extcheck.1 \
  --slave /usr/share/man/man1/idlj.1 idlj.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/idlj.1 \
  --slave /usr/share/man/man1/jar.1 jar.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jar.1 \
  --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jarsigner.1 \
  --slave /usr/share/man/man1/javac.1 javac.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/javac.1 \
  --slave /usr/share/man/man1/javadoc.1 javadoc.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/javadoc.1 \
  --slave /usr/share/man/man1/javah.1 javah.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/javah.1 \
  --slave /usr/share/man/man1/javap.1 javap.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/javap.1 \
  --slave /usr/share/man/man1/jcmd.1 jcmd.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jcmd.1 \
  --slave /usr/share/man/man1/jconsole.1 jconsole.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jconsole.1 \
  --slave /usr/share/man/man1/jdb.1 jdb.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jdb.1 \
  --slave /usr/share/man/man1/jdeps.1 jdeps.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jdeps.1 \
  --slave /usr/share/man/man1/jhat.1 jhat.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jhat.1 \
  --slave /usr/share/man/man1/jinfo.1 jinfo.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jinfo.1 \
  --slave /usr/share/man/man1/jmap.1 jmap.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jmap.1 \
  --slave /usr/share/man/man1/jps.1 jps.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jps.1 \
  --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jrunscript.1 \
  --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jsadebugd.1 \
  --slave /usr/share/man/man1/jstack.1 jstack.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jstack.1 \
  --slave /usr/share/man/man1/jstat.1 jstat.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jstat.1 \
  --slave /usr/share/man/man1/jstatd.1 jstatd.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/jstatd.1 \
  --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/native2ascii.1 \
  --slave /usr/share/man/man1/rmic.1 rmic.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/rmic.1 \
  --slave /usr/share/man/man1/schemagen.1 schemagen.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/schemagen.1 \
  --slave /usr/share/man/man1/serialver.1 serialver.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/serialver.1 \
  --slave /usr/share/man/man1/wsgen.1 wsgen.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/wsgen.1 \
  --slave /usr/share/man/man1/wsimport.1 wsimport.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/wsimport.1 \
  --slave /usr/share/man/man1/xjc.1 xjc.1 /usr/lib/jvm/${OPENJ9_VERSION}/man/man1/xjc.1

RUN update-alternatives --auto java && java -version

USER 1000
