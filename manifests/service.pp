class icinga::service {
    service { "icinga":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }
}
