class icinga::install {
    package { 'icinga':
        ensure => 'installed',
        require => Package['icinga'],
    }
}
