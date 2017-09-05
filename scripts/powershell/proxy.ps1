# Encoding::Shift-JIS
$user = "<http_proxy_user>"
$password = "<http_proxy_password>"
$proxyhost = "<http_proxy_host>:<http_proxy_port>"
$proxyaddress = "http://" + $proxyhost + "/"
$env:http_proxy = "http://" + $user +":" + $password +"@" + $proxyhost
$env:https_proxy = "http://" + $user +":" + $password +"@" + $proxyhost
$env:ftp_proxy = "http://" + $user +":" + $password +"@" + $proxyhost
$env:chocolateyProxyUser = $user
$env:chocolateyProxyPassword = $password
$env:chocolateyProxyLocation = $proxyaddress
$password = ConvertTo-SecureString $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential $user, $password
$proxy = New-Object System.Net.WebProxy $proxyaddress
$proxy.Credentials = $creds
[System.Net.WebRequest]::DefaultWebProxy = $proxy
