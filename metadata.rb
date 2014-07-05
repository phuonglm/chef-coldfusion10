name             "coldfusion11"
maintainer       "Ly Minh Phuong"
maintainer_email "phuonglm@teracy.com"
license          "Apache 2.0"
description      "Installs/Configures Adobe ColdFusion 11"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.12"

%w{ centos redhat ubuntu }.each do |os|
  supports os
end

depends "sudo"
suggests "apt"
suggests "apache2"

recipe "coldfusion11", "Includes the standalone, jvmconfig, and update recipes if the installer type is standalone (the default), or the j2ee recipe if installer type is ear or war."
recipe "coldfusion11::apache", "Configures ColdFusion to run behind the Apache httpd web server"
recipe "coldfusion11::configure", "Sets ColdFusion configuration settings via the config LWRP"
recipe "coldfusion11::install", "Runs the ColdFusion installer"
recipe "coldfusion11::j2ee", "Includes the install recipe and explodes the ear if installer type is ear."
recipe "coldfusion11::jvmconfig", "Sets necessary JVM configuration"
recipe "coldfusion11::lockdown", "Locks down CFIDE and ColdFusion pieces in web server"
recipe "coldfusion11::standalone", "Installs ColdFusion 11 in standalone mode"
recipe "coldfusion11::tomcat", "Enables SSL and changes webroot for built in Tomcat webserver"
recipe "coldfusion11::trustedcerts", "Imports certificates from a data bag into the JVM truststore"
recipe "coldfusion11::updates", "Applies ColdFusion updates"
