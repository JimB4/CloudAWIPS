
# CloudStream AWIPS <IMG SRC="https://travis-ci.org/mjames-upc/CloudAWIPS.svg?branch=master"/> <IMG SRC="https://img.shields.io/docker/pulls/unidata/cloudawips.svg"/>

This [docker image](https://hub.docker.com/r/unidata/cloudawips/) contains an instance of Unidata AWIPS CAVE running in a virtual X11 environment provided by [CloudStream](https://github.com/Unidata/cloudstream), accessed via a web browser. This fork addresses the changing centos7 OS software repo location(s) and includes some minor refactoring of the docker build approach.

There is some work to do to reduce the size of the resulting docker image. Testing shows that this update successfully builds by using the make command in the build directory.

#### Run AWIPS CAVE

From the command line, run

    docker run -p 6080:6080 -it unidata/cloudawips

and then open [http://localhost:6080](http://localhost:6080)

A new script named "run_CloudAWIPS.sh" has been added to include the host's cgroup and shm sys devices. A /tmp directory is added to provide a little elbow room. The script isn't particularly sophisticated but improvements are on the todo list.

![](https://www.unidata.ucar.edu/software/awips2/images/CloudAWIPS.jpg)

#### Build AWIPS CAVE Docker Image

    git clone https://github.com/JimB4/CloudAWIPS.git
    cd CloudAWIPS
    make build

### Notes

* Specify the width and height on the command line:

      docker run -p 6080:6080 -e SIZEW=1024 -e SIZEH=768 jimb4/cloudawips

* This repository uses a modified `bootstrap.sh` which overrides the `unidata/cloudstream:centos7` file of the same name.
* AWIPS CAVE is the only application accessible through this app streaming environment, and is run full-screen, with no window decorations or titlebar.
* If you wish to run multiple sessions, or leverage dynamic port mapping, you would start CloudAWIPS as follows:

      docker run -P -it jimb4/cloudawips

* By default, CloudAWIPS does not use a password. You may secure your CloudAWIPS session with a password by using the `USEPASS` environmental variable to set a password for the session.  

      docker run -e USEPASS="password" -P -it jimb4/cloudawips

