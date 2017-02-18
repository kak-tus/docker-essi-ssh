max_stale = "2m"

template {
  source = "/root/config.template"
  destination = "/home/www-data/.ssh/config"
}

template {
  source = "/root/init_hosts.sh.template"
  destination = "/usr/local/bin/init_hosts.sh"
  perms = 0755
}

exec {
  command = "/usr/local/bin/start.sh"
  splay = "60s"
}
