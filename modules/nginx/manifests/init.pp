class nginx {
  File {
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  }

case $facts['os']['family'] {
  'RedHat': {
  $package_name = 'nginx'
  $document_root = '/var/www'
  $config_directory = '/etc/nginx/'
  $user_service = 'nginx'
  }
  'Debian': {
  $package_name = 'nginx'
  $document_root = '/var/www'
  $config_directory = '/etc/nginx/'
  $service_name = 'nginx'
  }
  'windows': {
  $package_name = 'nginx-service'
  $document_root = 'C:/ProgramData/nginx/html'
  $config_directory = 'C:/ProgramData/nginx/conf'
  $service_name = 'nginx'
  }
  default: {
    fail("Operating system family ${facts['os']['family']} is not supported.")
  }
}

package { $package_name:
  ensure => 'present',
  }

file { $document_root :
  ensure => 'directory',
  }

file { "${document_root}/index.html":
  ensure     => file,
  source => 'puppet:///modules/nginx/index.html',
}

file { "${config_directory}/nginx.conf":
   ensure => file,
   source => "puppet:///modules/nginx/${facts['os']['family']}.conf",
   notify => Service[$service_name],
                    }
service { $service_name:
    ensure => running,
    enable => true,
}
}
