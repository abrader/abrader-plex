#Plex

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Backwards compatibility information](#backwards-compatibility)
4. [Setup - The basics of getting started with plexmediaserver](#setup)
    * [What plexmediaserver affects](#what-plexmediaserver-affects)
    * [Beginning with plexmediaserver](#beginning-with-plexmediaserver)
5. [Usage - Configuration options and additional functionality](#usage)
6. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
7. [Limitations - OS compatibility, etc.](#limitations)
8. [Development - Guide for contributing to the module](#development)

##Overview

The plex module installs, configures, and manages the Plex service.

##Module Description

The plex module manages both the installation and configuration of Plex

##Backwards Compatibility

TODO

##Setup

###What Plex affects

* Plex package
* Plex configuration files
* Plex service

###Beginning with Plex

If you just want a server installed with the default options you can run
`include '::plex::server'`.  

```puppet
class { '::plex::server':
  version    => 'complete_version',
}
```

##Usage

All interaction for the server is done via `plex::server`.  To install the
client you use `plex::client`.

###Custom configuration

TODO

##Reference

###Classes

####Public classes
* `plex::server`: Installs and configures Plex.
* `plex::client`: Installs Plex client (for non-servers).

####Private classes

TODO

###Parameters

####plex::server

#####`package_ensure`

What to set the package to.  Can be 'present', 'absent', or 'x.y.z'.

####plexmediaserver::client

TODO

###Defines

TODO

###Providers

TODO

##Limitations

This module has been tested on:

* RedHat Enterprise Linux 5/6/7
* CentOS 5/6/7

Testing on other platforms has been light and cannot be guaranteed.

### Authors

This module is based on work by Andrew Brader.

