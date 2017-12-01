#include nginx

class { 'nginx':
  sendfile_config    => 'off',
  enable_onboot      => false,
 }
