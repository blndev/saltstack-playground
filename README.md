# Saltstack-Playground
Virtualbox based Dev/Test System for Salt.

It's based on the original Salt Demo Environment with a gew fixes and modifications.
You still can run all of the Tutorials menationed in the "getting Started" documentation:
 https://docs.saltstack.com/en/getstarted/fundamentals/install.html  


## Prepare Environment
If you run VirtuaBox 6.1 you need to patch Vagrant manually, because VB6.1 it's currently not officially supported.

The change are only a few lines of code and well described.
Please check details here: https://github.com/oracle/vagrant-boxes/issues/178

## My Setup

* Master - Master Server and as well a Minion0
* Minion 1, 2 - Prepared with individual key and auto accept
* Minion 3 - client installed with a different Key than announced on the sever - result should be denied (test for an exchanged cert)
* Minion 4 - occurs as unknown key, needs to be accepted (shared Key with Minion 2)
* Minion 5,6 - using a self created keys and shared config - both getting fqdn and needs to be accepted by salt-key

## Terminology

Pillar: a file with dynamic variables, pushed and executed on each minion
Salt: a Package (SLS File) which defines a set of actions to be executed on each minion

## Getting started

To start work with Salt you need the following commands.
But i would suggest to run the tutorials mentioned above first.

````bash
vagrant up
vagrant ssh master
sudo su -
````

### check all Minions
````bash
salt-key --list-all
salt-key --accept=<key> #or --accept-all 
salt '*' test.ping
````

### Apply a Package

````bash
salt '*' state.apply examples
````


### Send new Pillars to Minions
````bash
salt '*' saltutil.refresh_pillar
salt '*' pillar.items
````
