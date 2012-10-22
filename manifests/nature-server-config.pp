#defines default values for subsequent calls of exec
Exec {
   path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin", "/usr/local/bin"],
   user => $user,
   cwd => $home,
   logoutput => "on_failure",
}

#defines default values for subsequent calls of file
File {
   owner => $user,
   group => $user,
   mode => 0644,
}

#defines default values for subsequent calls of package
Package {
   ensure => latest,
}

exec {"apt-get_update":
       command => "apt-get update",
       before => Exec["apt-get_upgrade"],
       user => root,
   }

exec {"apt-get_upgrade":
       command => "apt-get upgrade -y",
       before => Package["base_cmd_tools"],
       user => root,
   }

package {"base_cmd_tools":
       name => [
           "build-essential", #essentials :-)
           "curl", #call url
           "git", # vcs
           "htop", #human readable top (processes)
           "landscape-common",
           "default-jre",
           "jetty",
           "mongodb",
           "nano",
           "maven2",
       ],
   }
