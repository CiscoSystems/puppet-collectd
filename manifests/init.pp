# Class: collectd
# Edgar Magana (eperdomo@cisco.com)
#
# This class installs collectd
#
# Actions:
#   - Install the collectd package
#
# Sample Usage:
#  class { 'collectd': }
#
class collectd ( $graphitehost, $management_interface ) {
  service { 'collectd':
    ensure  => 'running',
    enable  => 'true',
    require => Package['collectd'],
  }

  package { 'collectd':
    ensure => installed,
  }

  file { '/etc/collectd/collectd.conf':
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    require => Package['collectd'],
    notify  => Service['collectd'],
    content => template('collectd/collectd.erb'),
  }

  file { '/etc/collectd/collectd-plugins':
    ensure  => 'directory',
    require => Package['collectd'],
  }

  file { '/etc/collectd/collectd-plugins/carbon_writer.py':
    ensure  => present,
    notify  => Service['collectd'],
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/collectd/carbon_writer.py',
    require => Package['collectd'],
  }

  file { '/etc/collectd/carbon-writer.conf':
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    require => Package['collectd'],
    notify  => Service['collectd'],
    content => template('collectd/carbon-writer.conf.erb'),
  }
}
