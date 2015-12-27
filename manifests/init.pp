

import 'syspackage.pp'
import 'devpackages.pp'
import 'securitypackages.pp'
import 'svn.pp'
#import 'apacheconfig.pp' 
#import 'ftp.pp'
import 'installedfiles.pp'
import 'bashaliases.pp'
import 'syncthing.pp'

class setup {
    require devpackages
    require securitypackages
    require svn
    #require apacheconfig
    #require ftp
    require bashaliases
    require syncthing

  user { 'deploy':
    ensure  => 'present',
    comment => 'deploy',
    home    => '/var/www',
    shell   => '/bin/bash',
  }

  user { 'deploy2':
    ensure  => 'present',
    comment => 'deploy',
    home    => '/var/www',
    shell   => '/bin/bash',
  }

  user { 'user':
    ensure  => 'present',
    comment => 'user',
    home    => '/var/www',
    shell   => '/bin/bash',
  }

  user { 'ssh_proxy':
    ensure  => 'present',
    comment => 'user',
    home    => '/home/ssh_proxy',
    shell   => '/bin/bash',
  }
}

class mainclass {
  include setup
  include installedfiles
  Class['setup'] -> Class['installedfiles']
}

include mainclass
