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
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'icinga':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# James Glenn <thedonkdonk@gmail.com>
#
# === Copyright
#
# Copyright 2015 James Glenn, unless otherwise noted.
#
class icinga (
    $package_name = 'icinga',
    $service_name = 'icinga',
    )
    {
    case $::osfamily {
        'RedHat': {
            yumrepo { 'icinga-stable-release':
                ensure  => 'present',
                baseurl  => 'http://packages.icinga.org/epel/$releasever/release/',
                descr    => 'ICINGA (stable release for epel)',
                enabled  => '1',
                gpgcheck => '1',
                gpgkey   => 'http://packages.icinga.org/icinga.key',
            }
        }
        default: {
            notify { "TODO: Add support for $::osfamily.":
                withpath => true,
            }
        }
    }
    package { "$package_name":
        ensure => 'installed'
    }
    service { "$service_name":
        ensure    => 'running',
        enable     => 'true',
        hasstatus  => 'true',
        hasrestart => 'true',
    }
    package { 'nagios-plugins-nrpe':
        ensure => 'installed',
    }
    file { '/etc/icinga/icinga.cfg':
        ensure => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template('icinga/icinga.cfg.erb'),
        notify  => Service['icinga']
    }
    file { '/etc/icinga/cgi.cfg':
        ensure => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template('icinga/cgi.cfg.erb'),
        notify  => Service['icinga']
    }
    Nagios_command <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_command.cfg'
    }
    Nagios_contact <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_contact.cfg'
    }
    Nagios_contactgroup <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_contactgroup.cfg'
    }
    Nagios_host <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_host.cfg'
    }
    Nagios_hostdependency <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_hostdependency.cfg'
    }
    Nagios_hostescalation <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_hostescalation.cfg'
    }
    Nagios_hostextinfo <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_hostextinfo.cfg'
    }
    Nagios_hostgroup <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_hostgroup.cfg'
    }
    Nagios_service <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_service.cfg'
    }
    Nagios_servicedependency <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_servicedependency.cfg'
    }
    Nagios_serviceescalation <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_serviceescalation.cfg'
    }
    Nagios_serviceextinfo <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_serviceextinfo.cfg'
    }
    Nagios_servicegroup <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_servicegroup.cfg'
    }
    Nagios_timeperiod <<||>> {
        notify  => Service['icinga'],
        owner => 'icinga',
        target => '/etc/icinga/conf.d/icinga_timeperiod.cfg'
    }

}
