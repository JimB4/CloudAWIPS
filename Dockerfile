#####
# Copyright Unidata 2018
# Used to generate the 'unidata/cloudawips' docker container.
# Visit us on the web at https://www.unidata.ucar.edu
#####

FROM unidata/cloudstream:centos7
MAINTAINER Jim Bayer <jim@jamesbayer.com>

###
# Install latest EL7 development release of AWIPS CAVE 
#
# Start as user root
###

USER root

### 
# Replace the yum.repos.d subdirectory with the one in the build directory. centos7 OS repo
# names and locations have changed due to it aging off. After some research I found the right names and URLs.
#
# As of August 2024, the command used to get the awips2.repo file for the new yum.repos.d directory:
#   wget -O <build directory path>/yum.repos.d/awips2.repo https://downloads.unidata.ucar.edu/awips2/current/linux/awips2.repo
#
# It's no longer necessary to retrieve the repo file each time you build.
###

WORKDIR /etc
RUN rm -rf yum.repos.d
COPY yum.repos.d yum.repos.d

RUN yum -y clean all
RUN rm -rf /var/cache/yum
RUN yum -y makecache fast

RUN groupadd fxalpha && useradd -G fxalpha awips
RUN yum groupinstall awips2-cave -y
RUN yum groupinstall "Fonts" -y

RUN yum install -y gtk2 mesa-libGLU mesa-libGL mesa-dri-drivers glib2 webkitgtk3

###
# The variable CUSER has the value "stream" and the user is already in the base image.
###

USER ${CUSER}

###
# Application files and localization preferences to auto-connect to edex-cloud, and open windows at full width
###

COPY localization.prefs ${HOME}/caveData/.metadata/.plugins/org.eclipse.core.runtime/.settings/
COPY workbench.xmi ${HOME}/caveData/.metadata/.plugins/org.eclipse.e4.workbench/workbench.xmi

###
# Populate the home directory for $CUSER
###

COPY bootstrap.sh ${HOME}/
COPY start.sh ${HOME}/
COPY Dockerfile ${HOME}/
COPY README.md ${HOME}/
COPY COPYRIGHT.md ${HOME}/

ENV COPYRIGHT_FILE COPYRIGHT.md
ENV README_FILE README.md

###
# Environmental variable control
###

USER root

RUN rm -rf /etc/profile.d/awips2.csh
RUN mv /etc/profile.d/awips2.sh ${HOME}
RUN chown -R ${CUSER}:${CUSER} ${HOME}

###
# Add the version number to the version file
###

RUN echo "CloudAWIPS Version: $(rpm -qa |grep awips2-cave-wrapper | cut -d "-" -f 4,5) $(date)" >> $VERSION_FILE

###
# Manual cleanup
###

RUN rm -rf /awips2/cave/plugins/com.raytheon.uf.viz.archive*.jar
RUN rm -rf /awips2/cave/plugins/com.raytheon.uf.viz.useradmin*.jar


###
# Override default windows session geometry and color depth.
###
ENV SIZEW 1280
ENV SIZEH 768
ENV CDEPTH 24

##
# get rid of the caveData directory that came in the image
###

USER ${CUSER}
WORKDIR ${HOME}

RUN rm -rf caveData

## Fluxbox desktop environment

USER root

RUN rm /usr/share/fluxbox/menu
COPY fluxbox/* .fluxbox/
RUN chown -R ${CUSER}:${CUSER} ${HOME}/.fluxbox

USER ${CUSER}

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE
ARG VCS_REF
ARG VCS_URL

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.description="An image based on centos 7 containing AWIPS CAVE and an X_Window_System" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"

###
#ENTRYPOINT bash
###

# = = = END = = =
