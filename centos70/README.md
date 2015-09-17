vagrant-centos65
===
 
Require
---

* vagrant
* vagrant-omnibus
* vagrant-proxyconf
* vagrant-hostupdater
* dotenv
* bundler

Usage
---

```
$ bundle exec berks vendor
$ vagrant up --provision
$ vagrant ssh-config --host vagrant-centos65 >> ~/.ssh/config
```
