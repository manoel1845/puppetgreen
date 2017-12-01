#include nginx

class { 'nginx':
  worker_connections => 2048,
  sendfile_config    => 'off',
  enable_onboot      => false,
  tcp_nodelay        => 'on',
  keepalive_timeout  => 120
 }
