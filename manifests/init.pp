# == Class: icinga
#
# Full description of class icinga here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
#  class { 'icinga::client': }
# === Authors
#
# Author Name <thedonkdonk@gmail.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class icinga {
    package { 'icinga':
        ensure => 'installed',
        require => Package['icinga'],
    }
    service { "icinga":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }

    Nagios_host <<||>>
    Nagios_service <<||>>

    class client {
    # Host Check
        @@nagios_host { "$::fqdn":
            ensure => present,
            alias => "$::hostname",
            address => "$::ipaddress",
            use => "linux-server",
            target => "/etc/icinga/hosts/${::hostname}_host.cfg"
        }
    # Service Checks
        @@nagios_service { "check_users_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_nrpe!check_users",
            service_description => "Current Users",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
        @@nagios_service { "check_load_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_nrpe!check_load",
            service_description => "Current Load",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
        @@nagios_service { "check_zombie_procs_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_nrpe!check_zombie_procs",
            service_description => "Zombie Processes",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
        @@nagios_service { "check_total_procs_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_nrpe!check_total_procs",
            service_description => "Total Processes",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
        @@nagios_service { "check_disks_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_nrpe!check_disk",
            service_description => "Disks",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
        @@nagios_service { "check_ssh_${::hostname}":
            ensure => present,
            use => "linux-service",
            host_name => "$::fqdn",
            check_command => "check_ssh",
            service_description => "SSH",
            target => "/etc/icinga/hosts/${::hostname}_services.cfg"
        }
    }
}


