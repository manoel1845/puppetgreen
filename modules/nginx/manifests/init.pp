class nginx {

  case $facts['os']['family'] {
    'RedHat': {
      $package_name = 'nginx'
      $docroot      = '/var/www'
      $confdir      = '/etc/nginx'
      $blockdir     = '/etc/nginx/conf.d'
      $logdir       = '/var/log/nginx'
      $service_user = 'nginx'
      $service_name = 'nginx'
    }
    'Debian': {
      $package_name = 'nginx'
      $docroot      = '/var/www'
      $confdir      = '/etc/nginx'
      $blockdir     = '/etc/nginx/conf.d'
      $logdir       = '/var/log/nginx'
      $service_user = 'www-data'
      $service_name = 'nginx'
    }
    'windows': {
      $package_name = 'nginx-service'
      $docroot      = 'C:/ProgramData/nginx/html'
      $confdir      = 'C:/ProgramData/nginx/conf'
      $blockdir      = 'C:/ProgramData/nginx/conf.d'
      $logdir       = 'C:/ProgramData/nginx/logs'
      $service_user = 'nobody'
      $service_name = 'nginx'
    }
    default: {
        fail("O sistema ${facts['os']['family']} não é suportado.")
    }
  }

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0664'
  }

  package { $package_name:
    ensure => installed,
  }

  file { $docroot:
    ensure => directory,
  }

  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html'
  }

  file { "${confdir}/nginx.conf":
    ensure => file,
    content => epp('nginx/nginx.conf.epp', {
      nginx_user     => $service_user,
      nginx_logdir   => $logdir,
      nginx_confdir  => $confdir,
      nginx_blockdir => $blockdir,
      nginx_docroot  => $docroot,
      }),
    notify => Service[$service_name],
  }

  service { $service_name:
    ensure => running,
    enable => true,
  }

}

