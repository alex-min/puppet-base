class installedfiles {

	file {'/root/.forward':
		ensure  => present,
		owner => root,
		mode    => 0640,
      	group => root,
      	content => "minette.alexandre+dedicated@gmail.com",
	}
    file {'/root/server_installed':
      ensure  => present,
      mode    => 0640,
      owner => root,
      group => root,
      content => "installed",
    } -> notify {"Server installed.":}
}