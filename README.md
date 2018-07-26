# Eclipse OpenJ9 Source-to-Image builder image

This repository contains an S2I builder image for OpenShift using [Eclipse OpenJ9](https://www.eclipse.org/openj9/) 
(based on OpenJDK and Java 8).

This image is intended to be a drop in replacement for
[fabric8/s2i-java](https://hub.docker.com/r/fabric8/s2i-java/).

It is based on the Java S2I image from
[farbic8io-images/java](https://github.com/fabric8io-images/s2i#java-s2i-builder-image).
It downloads and unpacks OpenJ9 in addition and uses the "alternatives" system to redirect
all Java commands to OpenJ9.

**Note:** This is for testing only. Use at your own risk!
