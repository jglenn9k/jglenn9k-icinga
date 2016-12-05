# == Class: icinga
#
# Setup and configure Icinga server. Leverages exported resources for configs.
#
# === Parameters
#
#
# === Examples
#
#  class { 'icinga':
#  }
#
# === Authors
#
# James Glenn <jglenn9k@gmail.com>
#
# === Copyright
#
# Copyright 2016 James Glenn, unless otherwise noted.
#
class icinga (
    $package_name = 'icinga',
    $service_name = 'icinga',
    ) inherits icinga::config
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
