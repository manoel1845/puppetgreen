class hosts {

host { 'itau':
  ensure       => 'present',
  host_aliases => ['itau.puppetlabs.vm','itau'],
  ip           => '192.168.3.112',
  comment      => 'Servidor do Doug',
  target       => '/etc/hosts'
  }
}
