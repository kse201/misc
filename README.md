vagrant-centos65
===
 
Require
---

* vagrant
* vagrant-omnibus
* vagrant-proxyconf
* bundler

Usage
---

```
$ bundle exec berks vendor ./cookbooks
$ vagrant up --provision
$ vagrant ssh-config --host vagrant-centos65 >> ~/.ssh/config
```
