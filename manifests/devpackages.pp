import 'syspackage.pp'


class devpackages {
		require syspackage::update

		notify {"Installing base development packages":} 

	    case $operatingsystem {
	    	/(?i)(ubuntu|debian)/: {
			package { "php5-cli": ensure => installed, }
			package { "php5-curl": ensure => installed, }
			package { "php5-intl": ensure => installed, }
			package { "php5-mcrypt": ensure => installed, }
			package { "php5-mysql": ensure => installed, }			
			
			package { "nginx": ensure => installed, }
			package { "sysdig": ensure => installed, }
	    		package { "mysql-server": ensure => installed, }
	    		package { "mysql-client": ensure => installed, }
	    		package { "php-apc": ensure => installed, }
	    		package { "mailutils": ensure => installed, }


	    		# editor
	    		package { "emacs24-nox": ensure => installed, }
	    		package { "vim": ensure => installed, }
	    	
	    		# compilation
	    		package { "g++": ensure => installed, }
	    		package { "binutils": ensure => installed, }
	    		package { "build-essential": ensure => installed, }
	    		
	    		# zip
	    		package { "unp": ensure => installed, }
	    		package { "unzip": ensure => installed, }

	    		# scm
	    		package { "git": ensure => installed, }
	    		package { "git-core": ensure => installed, }

	    		# languages
	    		package { "python2.7": ensure => installed, }
	    		package { "python-pip": ensure => installed, }
	    		package { "python-dev": ensure => installed, }
	    		package { "ruby": ensure => installed, }
	    		package { "gem": ensure => installed, }


				exec { "php_composer_install":
				    command => "curl -sS https://getcomposer.org/installer | php",
				    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
				    require => [Package['php5-cli'], Package['curl']],
				 	creates => '/usr/local/bin/composer'
				}
				exec { "mv_composer":
					command => 'mv composer.phar /usr/local/bin/composer',
				    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
					require => [Exec['php_composer_install']],
					creates => '/usr/local/bin/composer'
				}

	    		# network
	    		package { "openssh-server": ensure => installed, }
	    		package { "telnet": ensure => installed, }	    		
	    		package { "wget": ensure => installed, }
	    		package { "dnsutils": ensure => installed, }
	    		package { "curl": ensure => installed, }


	    		#libraries
	    		package { "zlib1g-dev": ensure => installed, }
	    		package { "libssl-dev": ensure => installed, }
	    		package { "libreadline6-dev": ensure => installed, }
	    		package { "libyaml-dev": ensure => installed, }

	    		# deployment
				package { 'capistrano':
				    ensure   => 'installed',
				    provider => 'gem',
				}
				package { 'railsless-deploy':
				    ensure   => 'installed',
				    provider => 'gem',
				}

				# system
				package { "htop": ensure => installed, }
				package { "bash": ensure => installed, }
	    	}
	    }
}