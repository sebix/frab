# $as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

include rvm
rvm::system_user { vagrant: ; }

if $rvm_installed == "true" {
  rvm_system_ruby {
    'ruby-1.9.3-p385':
      ensure => 'present';
  }
}

# --- Node.js ------------------------------------------------------------------

# ExecJS runtime.
package { 'nodejs':
  ensure => installed
}

package { 'imagemagick':
  ensure => installed
}

# --- Preinstall Stage ---------------------------------------------------------

# stage { 'preinstall':
#   before => S tage['main']
# }
# 
# class apt_get_update {
#   exec { 'apt-get -y update':
#     unless => "test -e ${home}/.rvm"
#   }
# }
# class { 'apt_get_update':
#   stage => preinstall
# }
# 
# # --- SQLite -------------------------------------------------------------------
# 
# package { ['sqlite3', 'libsqlite3-dev']:
#   ensure => installed;
# }
# 
# # --- MySQL --------------------------------------------------------------------
# 
# class install_mysql {
#   class { 'mysql': }
# 
#   class { 'mysql::server':
#     config_hash => { 'root_password' => '' }
#   }
# 
#   database { $ar_databases:
#     ensure  => present,
#     charset => 'utf8',
#     require => Class['mysql::server'] 
#   }
# 
#   database_user { 'rails@localhost':
#     ensure  => present,
#     require => Class['mysql::server'] 
#   }
# 
#   database_grant { ['rails@localhost/activerecord_unittest', 'rails@localhost/activerecord_unittest2']:
#     privileges => ['all'],
#     require    => Database_user['rails@localhost']
#   }
# 
#   package { 'libmysqlclient15-dev':
#     ensure => installed
#   }
# }
# class { 'install_mysql': }
# 
# # --- PostgreSQL ---------------------------------------------------------------
# 
# class install_postgres {
#   class { 'postgresql': }
# 
#   class { 'postgresql::server': }
# 
#   pg_database { $ar_databases:
#     ensure   => present,
#     encoding => 'UTF8',
#     require  => Class['postgresql::server']
#   }
# 
#   pg_user { 'rails':
#     ensure  => present,
#     require => Class['postgresql::server'] 
#   }
# 
#   pg_user { 'vagrant':
#     ensure    => present,
#     superuser => true,
#     require   => Class['postgresql::server']
#   }
# 
#   package { 'libpq-dev':
#     ensure => installed
#   }
# }
# class { 'install_postgres': }
# 
# # --- Memcached ----------------------------------------------------------------
# 
# class { 'memcached': }
# 
# # --- Packages -----------------------------------------------------------------
# 
# package { 'curl':
#   ensure => installed
# }
# 
# package { 'build-essential':
#   ensure => installed
# }
# 
# package { 'git-core':
#   ensure => installed
# }
# 
# # Nokogiri dependencies.
# package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
#   ensure => installed
# }
# 
 
# # --- Ruby ---------------------------------------------------------------------
 
# exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
#   creates => "${home}/.rvm/bin/bundle",
#   require => Exec['install_ruby']
# }
# 
# exec { "${as_vagrant} 'gem install rails --no-rdoc --no-ri'":
#   creates => "${home}/.rvm/bin/rails",
#   require => Exec['install_ruby']
# }