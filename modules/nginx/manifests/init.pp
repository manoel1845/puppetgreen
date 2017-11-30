class nginx {

package { 'nginx':
  ensure => 'installed',
  }

file { '/var/www':
  ensure => 'directory',
  mode   => '0755',
}

file { '/var/www/index.html':
  ensure => 'file',
  mode   => '0644',
  source => 'puppet:///modules/nginx/index.html',
  }

service { 'nginx.service':
  ensure    => 'running',
  enable    => 'true',
  subscribe => File['/etc/nginx/nginx.conf'],
  }

file { '/etc/nginx/nginx.conf':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/nginx/nginx.conf',
  }
}
