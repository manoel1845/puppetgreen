class nginx {

package { 'nginx':
  ensure => 'present',
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
  ensure => 'running',
  enable => 'true',
  }
}
