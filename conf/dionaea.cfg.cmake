[dionaea]
download.dir=@DIONAEA_STATEDIR@/binaries/
modules=curl,python,nfq,emu,pcap
processors=filter_streamdumper,filter_emu

listen.mode=getifaddrs
# listen.addresses=127.0.0.1
# listen.interfaces=eth0,tap0

# Use IPv4 mapped IPv6 addresses
# It is not recommended to use this feature, try to use nativ IPv4 and IPv6 adresses
# Valid values: true|false
# listen.use_ipv4_mapped_ipv6=false

# Country
# ssl.default.c=GB
# Common Name/domain name
# ssl.default.cn=
# Organization
# ssl.default.o=
# Organizational Unit
# ssl.default.ou=

[logging]
default.filename=@DIONAEA_LOGDIR@/dionaea.log
default.levels=all
default.domains=*

errors.filename=@DIONAEA_LOGDIR@/dionaea-errors.log
errors.levels=warning,error
errors.domains=*

[processor.filter_emu]
name=filter
config.allow.0.protocols=smbd,epmapper,nfqmirrord,mssqld
next=emu

[processor.filter_streamdumper]
name=filter
config.allow.0.types=accept
config.allow.1.types=connect
config.allow.1.protocols=ftpctrl
config.deny.0.protocols=ftpdata,ftpdatacon,xmppclient
next=streamdumper

[processor.streamdumper]
name=streamdumper
config.path=@DIONAEA_STATEDIR@/bistreams/%Y-%m-%d/

[processor.emu]
name=emu
config.limits.files=3
#512 * 1024
config.limits.filesize=5242880
config.limits.sockets=3
config.limits.sustain=120
config.limits.idle=30
config.limits.listen=30
config.limits.cpu=120
#// 1024 * 1024 * 1024
config.limits.steps=1073741824

[module.nfq]
queue=2

[module.nl]
# set to yes in case you are interested in the mac address  of the remote (only works for lan)
lookup_ethernet_addr=no

[module.python]
imports=dionaea.log,dionaea.services,dionaea.ihandlers
sys_paths=default
service_configs=@DIONAEA_CONFDIR@/services-enabled/*.yaml
ihandler_configs=@DIONAEA_CONFDIR@/ihandlers-enabled/*.yaml

[module.pcap]
any.interface=any

