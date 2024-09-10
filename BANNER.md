
This is a fork of the original project at https://hub.docker.com/r/unidata/cloudawips that produces a docker image
of Unidata AWIPS CAVE running in a virtual X11 environment provided by CloudStream (https://github.com/Unidata/cloudstream),
accessed via a web browser. 

This fork addresses the changing centos7 OS software repo location(s) and includes some minor refactoring of the 
docker build approach.

There is some work to do to reduce the size of the resulting docker image. Testing shows that this update successfully 
builds by running the make command in the build directory.

--------------------------------------------------------------------------------
Copyright 2018 University Corporation for Atmospheric Research and contributors.
All rights reserved.

This software was developed by the Unidata Program Center of the
University Corporation for Atmospheric Research (UCAR)
<http://www.unidata.ucar.edu>.

