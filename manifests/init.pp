# == Class: icinga
#
# Full description of class icinga here.
#
# === Parameters
#
# Document parameters here.
#
# [*icinga_host*]
#   Set this to your Icinga Server. It's used to allow the Icinga host to connect to the nrpe daemon.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#  Include this on your Icinga server.
#  class { 'icinga': }
#
#  Inlcude this on your Icinga client.
#  class { 'icinga::client': 
#      icinga_host => '10.10.1.1',
#  }
# === Authors
#
# Author Name <thedonkdonk@gmail.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class icinga {
    include icinga::service, icinga::install, icinga::config

    Nagios_host <<||>> {
        notify  => Service['icinga']
    }
    Nagios_service <<||>> {
        notify  => Service['icinga']
    }
}


