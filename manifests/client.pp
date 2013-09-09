class icinga::client ($icinga_host) {
    package { 'nrpe':
        ensure => 'installed',
    }
    service { 'nrpe':
        ensure => 'running',
        enable => true,
        hasrestart => true,
        hasstatus => true        
    }
    file { '/etc/nagios/nrpe.cfg':
        ensure  => present,
        content => template('icinga/nrpe.cfg.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
        require => Package['nrpe'],
        notify  => Service['nrpe'],
    }

# Host Check
    @@nagios_host { "$::fqdn":
        ensure => present,
        alias => "$::hostname",
        address => "$::ipaddress",
        use => "linux-server",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
# Service Checks
    @@nagios_service { "check_users_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_nrpe!check_users",
        service_description => "Current Users",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
    @@nagios_service { "check_load_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_nrpe!check_load",
        service_description => "Current Load",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
    @@nagios_service { "check_zombie_procs_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_nrpe!check_zombie_procs",
        service_description => "Zombie Processes",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
    @@nagios_service { "check_total_procs_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_nrpe!check_total_procs",
        service_description => "Total Processes",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
    @@nagios_service { "check_disks_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_nrpe!check_disk",
        service_description => "Disks",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
    @@nagios_service { "check_ssh_${::hostname}":
        ensure => present,
        use => "linux-service",
        host_name => "$::fqdn",
        check_command => "check_ssh",
        service_description => "SSH",
        target => "/etc/icinga/hosts/${::hostname}.cfg"
    }
}