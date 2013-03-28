alias l='ls -ltrahG'
set -o vi

#git config --global url.https://github.com/.insteadOf git://github.com/

proxyserver="yourproxyserver.com:8080"

function proxy(){
  echo -n "Proxy Server ($proxyserver):" 
  read -e promptproxy
  proxyserver=${promptproxy:-$proxyserver}
  echo -n "username:"
  read -e username
  echo -n "password:"
  read -es password
  export http_proxy="http://$username:$password@$proxyserver"
  export https_proxy=$http_proxy
  export ftp_proxy="ftp://$username:$password@$proxyserver"
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com,.local"
  alias sudop="sudo http_proxy=$http_proxy https_proxy=$https_proxy ftp_proxy=$ftp_proxy no_proxy=$no_proxy"
  echo -e "\nProxy environment variable set."
}
 
function proxyoff(){
  unset HTTP_PROXY
  unset http_proxy
  unset HTTPS_PROXY
  unset https_proxy
  unset FTP_PROXY
  unset ftp_proxy
  unalias sudop
  echo -e "\nProxy environment variable removed."
}

