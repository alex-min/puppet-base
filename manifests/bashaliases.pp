class bashaliases {
	file { "/root/.bashrc":
         mode => 440,
         owner => root,
         group => root,
         source => "puppet:///modules/bash/.bashrc"
	}
	file { "/usr/bin/add_website":
         mode => 111,
         owner => root,
         group => root,
         source => "puppet:///modules/bash/add_website"
	}

file { [ "/home", "/home/user"]:
		ensure => "directory"
	} ->
	file { "/home/user/.bashrc":
         mode => 440,
         owner => root,
         group => root,
         source => "puppet:///modules/bash/.bashrc"
	}
}
