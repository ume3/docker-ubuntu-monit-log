## Dcoker+Ubuntu+Monit+Fluentd
* このDockerfileをbuildすると、monitでfluentd,sshdが立ち上がります

### Mac環境の場合
* boot2docker(virualbox) を想定するとポートフォワーディングが必要
* sshdを(10000:22)でログインしたい場合

```
% VBoxManage controlvm "boot2docker-vm" natpf1 "ssh_container,tcp,127.0.0.1,10000,,10000"
%  VBoxManage showvminfo boot2docker-vm | grep Rule
NIC 1 Rule(0):   name = ssh_container, protocol = tcp, host ip = 127.0.0.1, host port = 10000, guest ip = , guest port = 10000
```

* `docker run -dt -p 10000:22 <continer>`

