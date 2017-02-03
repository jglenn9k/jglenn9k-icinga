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
# James Glenn <thedonkdonk@gmail.com>
#
# === Copyright
#
# Copyright 2017 James Glenn, unless otherwise noted.
#
class icinga (
    $package_name = 'icinga',
    $service_name = 'icinga',
    $user_name    = 'icinga',
    $group_name   = 'icinga',
    $log_file     = '/var/log/icinga/icinga.log'
    )
{
    case $::osfamily {
        'RedHat': {
            yumrepo { 'icinga-stable-release':
                ensure   => 'present',
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
    package { 'icinga':
        name   => "$package_name",
        ensure => 'installed',
    }
    service { 'icinga':
        name       => "$service_name",
        ensure     => 'running',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
    }
    package { 'nagios-plugins-nrpe':
        ensure => 'installed',
    }
    package { 'icinga-gui':
        ensure => 'installed',
    }
    file { '/etc/icinga/icinga.cfg':
    ensure => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('icinga/icinga.cfg.erb'),
        notify  => Service['icinga']
    }
    file { '/etc/icinga/cgi.cfg':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('icinga/cgi.cfg.erb'),
        notify  => Service['icinga']
    }
    Nagios_command <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_command.cfg'
    }
    Nagios_contact <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_contact.cfg'
    }
    Nagios_contactgroup <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_contactgroup.cfg'
    }
    Nagios_host <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_host.cfg'
    }
    Nagios_hostdependency <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_hostdependency.cfg'
    }
    Nagios_hostescalation <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_hostescalation.cfg'
    }
    Nagios_hostextinfo <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_hostextinfo.cfg'
    }
    Nagios_hostgroup <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_hostgroup.cfg'
    }
    Nagios_service <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_service.cfg'
    }
    Nagios_servicedependency <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_servicedependency.cfg'
    }
    Nagios_serviceescalation <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_serviceescalation.cfg'
    }
    Nagios_serviceextinfo <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_serviceextinfo.cfg'
    }
    Nagios_servicegroup <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_servicegroup.cfg'
    }
    Nagios_timeperiod <<||>> {
        notify => Service['icinga'],
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        target => '/etc/icinga/conf.d/icinga_timeperiod.cfg'
    }

}
