vagrant-centos65
===
 
Require:
===
vagrant
vagrant-omnibus
bundler

Usage:
===

```
$ bundle exec berks vender ./cookbooks
$ vagrant up --provision
$ vagrant ssh-config --host vagrant-centos65 >> ~/.ssh/config
```
