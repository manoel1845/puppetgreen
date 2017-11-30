class system_users::admins {

  group { 'staff':
    ensure => present,
  }

  user { 'admin':
    ensure => present,
    shell  => "/bin/csh",
    gid => "staff",
  }
}
