class apacheconfig {
  class { 'apache':
    service_enable => true,
    mpm_module => 'prefork'
  } ->
  case $operatingsystem {
      'Ubuntu', 'Debian': {
        file { "/etc/apache2/conf.d/security.conf":
            mode => 440,
            notify  => Service["apache2"],
            owner => root,
            group => root,
            source => "puppet:///modules/apache_files/security.conf"
        }
      }
  }

  apache::mod { 'rewrite': }

  apache::mod { 'php5': }

  class { 'php': }

  php::module { 'cli': } ->
  php::module { 'curl': } ->
  php::module { 'intl': } ->
  php::module { 'mcrypt': } ->
  php::module { 'mysql': }

  file { [ "/var/www"]:
    ensure => "directory"
  } ->
  file { "/var/www/index.html":
         mode => 440,
         owner => www-data,
         group => www-data,
         source => "puppet:///modules/apache_files/index.html"
  }
}