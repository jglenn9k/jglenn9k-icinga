class icinga::config inherits icinga {



    $user_name = 'icinga',
    $group_name = 'icinga',
    $log_file = '/var/log/icinga/icinga.log'


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

    }