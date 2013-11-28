class bashaliases {
	file { "/root/.bashrc":
         mode => 440,
         owner => root,
         group => root,
         source => "puppet:///modules/bash/.bashrc"
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
