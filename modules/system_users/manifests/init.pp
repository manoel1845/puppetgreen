class system_users {

  user { 'fundamentals':
    ensure => present,
  }

  system_users::dba { 'artur':
     homedir      => '/home/artur',
     group        => 'wheel',
     enable_admin => true,
  }

  system_users::dba { 'jessica':
     homedir      => '/home/jessica',
     group        => 'wheel',
     enable_admin => true,
  }

  system_users::dba { 'beatriz':
     homedir      => '/home/beatriz',
     group        => 'wheel',
     enable_admin => true,
  }

}
