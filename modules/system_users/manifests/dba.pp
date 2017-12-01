define system_users::dba(
  $username = $title,
  $group,
  $homedir,
  $enable_admin = false,
  ){

  user { $username:
    ensure     => present,
    gid        => $group,
    home       => $homedir,
    managehome => true,
  }

  if $enable_admin {
    file { "/etc/sudoers.d/admin_${username}":
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0440',
      content => "$username ALL=(ALL) ALL",
    }
  }
}
