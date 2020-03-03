# saltstack-playground
Virtualbox based Dev/Test System for Salt based on the https://docs.saltstack.com/en/getstarted/fundamentals/install.html  tutorial and demo sources.

## Prepare Environment
If you run VirtuaBox 6.1 you need to patch Bagrant manually, because it's currently ot supported.

Please check details here: https://github.com/oracle/vagrant-boxes/issues/178

## Our Setup

1 Master
Minion 1,2 - Prepared with individual key and auto accept
Minion 3 - client installed with a different Key than prepared on the sever - result should be denied (liek a revoked cert)
Minion 4 - unknown key, needs to be accepted (share Key with Minion 2)
Minion 5,6 - using a shared key and shared config - both getting fqdn and needs to be accepted

## getting started

To start work with Salt you need the following commands

````bash
vagrant up
vagrant ssh master
sudo su -
````

## check all Minions
````bash
salt-key --list-all
salt-key --accept=<key> #or --accept-all 
salt '*' test.ping
````