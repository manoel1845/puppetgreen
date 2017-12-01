class nginx(
  Integer $worker_connections       = 1024,
  Enum['on','off'] $sendfile_config = 'on',
  Boolean $enable_onboot            = true,
  Enum['on','off'] $tcp_nodelay     = 'on',
  Integer $keepalive_timeout        = 65,
  ) {

  package { $nginx::params::package_name:
    ensure => installed,
  }

  file { $nginx::params::docroot:
    ensure => directory,
  }

  file { "${nginx::params::docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html'
  }

  file { "${nginx::params::confdir}/nginx.conf":
    ensure                     => file,
    content                    => epp('nginx/nginx.conf.epp', {
      nginx_user               => $nginx::params::service_user,
      nginx_logdir             => $nginx::params::logdir,
      nginx_confdir            => $nginx::params::confdir,
      nginx_blockdir           => $nginx::params::blockdir,
      nginx_docroot            => $nginx::params::docroot,
      nginx_worker_connections => $worker_connections,
      nginx_sendfile           => $sendfile_config,
      nginx_tcp_nodelay        => $tcp_nodelay,
      nginx_keepalive_timeout  => $keepalive_timeout,
      }),
    notify => Service[$nginx::params::service_name],
  }

  service { $nginx::params::service_name:
    ensure => running,
    enable => $enable_onboot,
  }

}
