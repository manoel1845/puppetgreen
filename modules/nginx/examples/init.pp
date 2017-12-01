#include nginx

class { 'nginx':
  worker_connections => 1024,
  sendfile_config    => 'off',
  enable_onboot      => false,
  tcp_nodelay        => 'on',
  keepalive_timeout  => 120
 }
