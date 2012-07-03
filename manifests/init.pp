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
class collectd {

  service { "collectd":
	ensure  => "running",
	enable  => "true",
	require => Package["collectd"],
}

  package { 'collectd':
        ensure => installed,
  }
 
  file { "/etc/collectd/collectd.conf":
        notify  => Service["collectd"],
	ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 0755,
        source  => "puppet:///modules/collectd/collectd.conf",
	require => Package["collectd"],
    }
}
