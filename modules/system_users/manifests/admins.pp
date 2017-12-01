class system_users::admins {

  # 1. criar um grupo chamado staff

  group { 'staff':
    ensure => present,
  }

  # 2. criar um usuário chamado admin
    # 2.1 usuário deve pertencer ao grupo primário staff
    # 2.2 usuário deve usar o shell /bin/csh

  user { 'admin':
    ensure => present,
    gid    => 'staff',
    shell  => '/bin/csh',
  }

}
