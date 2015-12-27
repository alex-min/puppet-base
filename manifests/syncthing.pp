import 'syspackage.pp'

class syncthing {
      require syspackage::update

      notify {"Installing synthing":}

      exec { "install syncthing key":
      	   command => 'curl -s https://syncthing.net/release-key.txt | sudo apt-key add -',
	   require => [Package['curl']],
	   path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",	   
      }

      exec { "Add the release channel to your APT sources":
      	   command => 'echo "deb http://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list',
	   path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",	   	   
      }

      exec { "Add to nginx":
      	   command => '/usr/bin/add_website storage.$HOSTNAME proxy 4567',
	   path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
 	   }

      require syspackage::update

      package { "syncthing": ensure => installed, }

  user { 'data':
    ensure  => 'present',
    comment => 'user',
    home    => '/home/data',
    shell   => '/bin/bash',
  }

  file {"/etc/systemd/system/syncthing.service":
       mode => 440,
       owner => root,
       group => root,
       source => "puppet:///modules/syncthing/syncthing.service"
  } ->
  exec {"start syncthing":
       command => "systemctl start syncthing.service",
       path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }


  file { ["/home/data", "/home/data/Music", "/home/data/Ebooks"]:
      ensure => "directory",
      owner => data,
      group => data,
      mode => 700
  }
}