vagrant-aws
===
 
Require
---

* vagrant
* vagrant-aws


Usage
---

### export aws acount infomation

```
$ export AWS_ACCESS_KEY_ID="xxx"
$ export AWS_SECRET_KEY="xxxx"
$ export AWS_KEYPAIR_NAME="xxxx"
$ export AWS_PRIVATE_KEY_PATH="xxxx"
```

### create instance

```
$ vagrant up -provider=aws
$ vagrant ssh-config --host vagrant-aws >> ~/.ssh/config
```
