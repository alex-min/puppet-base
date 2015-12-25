

import 'syspackage.pp'
import 'devpackages.pp'
import 'securitypackages.pp'
import 'svn.pp'
import 'ftp.pp'
import 'installedfiles.pp'
import 'bashaliases.pp'

class setup {
    require devpackages
    require securitypackages
    require svn
    require apacheconfig
    require ftp
    require bashaliases

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
}

class mainclass {
  include setup
  include installedfiles
  Class['setup'] -> Class['installedfiles']
}

include mainclass
