class activemq ($activemqpassword) {

  package { 'activemq': ensure => installed }

  #Get the config file template and replace the password
  file { "replace_activemq_config":
    path       => "/etc/activemq/activemq.xml",
    content    => template("activemq/activemq.xml.erb"),
    ensure     => file,
    require   => [ Package["activemq"]]
  }

  service { 'activemq':
    enable     => true,
    ensure     => running,
    hasstatus  => false,
    hasrestart => true,
    status     => 'ps aux | grep "java -Dactivemq.home=/usr/share/activemq" | grep -v grep',
    require    => Package ['activemq'],
  }

}