# Source for all https://docs.saltstack.com/en/getstarted/config/functions.html

install nano:
  pkg.installed:
    - name: nano

remove vim:
  pkg.removed:
    - name: vim

create my_new_directory:
 file.directory:
   - name: /opt/my_new_directory
   - user: root
   - group: root
   - mode: 755

# Install mysql and make sure the mysql service is running:
#   pkg.installed:
#     - name: mysql
#   service.running:
#     - name: mysql

# Make sure the mysql service is running and enable it to start at boot:
#   service.running:
#     - name: mysql
#     - enable: True


Clone the SaltStack bootstrap script repo:
  pkg.installed: 
    - name: git # make sure git is installed first!
  git.latest:
    - name: https://github.com/saltstack/salt-bootstrap
    - rev: develop
    - target: /tmp/salt


user account for pete:
  user.present:
    - name: pete
    - shell: /bin/bash
    - home: /home/pete
    - groups:
      - sudo

myserver in hosts file:
  host.present:
    - name: myserver
    - ip: 192.168.0.42

restart vsftpd:
  module.run:
    - name: service.restart
    - m_name: vsftpd  # m_name gets passed to the execution module as "name"

execute some code:
  module.run:
    - name: ls
    - m_name: -a  # m_name gets passed to the execution module as "name"