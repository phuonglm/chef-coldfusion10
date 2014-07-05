
# Installer locations, one of these must be defined
# default['cf11']['installer']['url'] = "http://example.com/ColdFusion_11_WWEJ_linux32.bin"
# default['cf11']['installer']['cookbook_file'] = "ColdFusion_11_WWEJ_linux32.bin"
# default['cf11']['installer']['local_file'] = "/tmp/ColdFusion_11_WWEJ_linux32.bin"

# Apache SSL certificate files
case node['platform_family']
when 'rhel'
  default['cf11']['apache']['ssl_cert_file'] = "/etc/pki/tls/certs/localhost.crt"
  default['cf11']['apache']['ssl_cert_key_file'] = "/etc/pki/tls/private/localhost.key"
else
  default['cf11']['apache']['ssl_cert_file'] = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  default['cf11']['apache']['ssl_cert_key_file'] = "/etc/ssl/private/ssl-cert-snakeoil.key"
end

default['cf11']['apache']['ssl_cert_chain_file'] = nil

# Lock down /CFIDE/adminapi
default['cf11']['apache']['adminapi_whitelist'] = []

# Configuration 
default['cf11']['config_settings'] = {}

# CF secure profile IP addresses
default['cf11']['installer']['admin_ip'] = ""
# CF admin username
default['cf11']['installer']['admin_username'] = "admin"
# CF admin password
default['cf11']['installer']['admin_password'] = "vagrant"
# CF auto updates
default['cf11']['installer']['auto_enable_updates'] = "false"
# CF j2ee context root
default['cf11']['installer']['context_root'] = "/cfusion"
# CF rds
default['cf11']['installer']['enable_rds'] = "false"
# CF secure profile, enable secure profile, IP addresses from which Administrator can be accessed
default['cf11']['installer']['enable_secure_profile'] = "false"
# CF administrator
default['cf11']['installer']['install_admin'] = "true"
# CF install folder
default['cf11']['installer']['install_folder'] = "/opt/coldfusion11"
# CF jnbridge, applies only for Windows systems with .Net Framework installed. (.Net Integration Services)
default['cf11']['installer']['install_jnbridge'] = "false"
# CF odbc services
default['cf11']['installer']['install_odbc'] = "true"
# CF samples, the Getting Started Experience, Tutorials, and Documentation
default['cf11']['installer']['install_samples'] = "false"
# CF solr
default['cf11']['installer']['install_solr'] = "true"
# CF installer type, valid values are ear/war/standalone
default['cf11']['installer']['installer_type'] = "standalone"
# CF jetty username
default['cf11']['installer']['jetty_username'] = "admin"
# CF jetty password
default['cf11']['installer']['jetty_password'] = "vagrant"
# CF license mode, valid values are full/trial/developer
default['cf11']['installer']['license_mode'] = "developer"
#CF migrate coldfusion, applicable to non-Windows OSes only
default['cf11']['installer']['migrate_coldfusion'] = "false"
# CF encrypted password data bag (if available)
default['cf11']['installer']['password_databag'] = "installer_passwords"
#CF migrate coldfusion, applicable to non-Windows OSes only
default['cf11']['installer']['prev_cf_migr_dir'] = ""
# CF previous serial number, use when it is upgrade
default['cf11']['installer']['prev_serial_number'] = ""
# CF rds password
default['cf11']['installer']['rds_password'] = "vagrant"
#CF runtime user
default['cf11']['installer']['runtimeuser'] = "nobody"
# CF serial number
default['cf11']['installer']['serial_number'] = ""

# Lockdown settings
default['cf11']['lockdown']['cfide']['adminapi_whitelist'] = []
default['cf11']['lockdown']['cfide']['administrator_whitelist'] = []
default['cf11']['lockdown']['cfide']['air'] = false
default['cf11']['lockdown']['cfide']['classes'] = false
default['cf11']['lockdown']['cfide']['graphdata'] = false
default['cf11']['lockdown']['cfide']['scripts'] = false
default['cf11']['lockdown']['cfide']['scripts_alias'] = nil
default['cf11']['lockdown']['cffileservlet'] = false
default['cf11']['lockdown']['flash_forms'] = false
default['cf11']['lockdown']['flex_remoting'] = false
default['cf11']['lockdown']['rest'] = false
default['cf11']['lockdown']['wsrpproducer'] = false

# Node attributes to hold the instance and cluster data
default['cf11']['instances_xml'] = nil
default['cf11']['instances_local'] = nil
default['cf11']['instances_remote'] = nil
default['cf11']['cluster_xml'] = nil

# JVM Settings
default['cf11']['java']['args'] = %w{ 
  -Xms256m  
  -Xmx512m
  -XX:MaxPermSize=192m
  -XX:+UseParallelGC
}
default['cf11']['java']['home'] = nil

# CF Updates
default['cf11']['updates']['urls'] = %w{
}
default['cf11']['updates']['files'] = %w{
}

# Tomcat or Apache web root
default['cf11']['webroot'] = "/vagrant/wwwroot"
