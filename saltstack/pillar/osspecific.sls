# Sample for setting Variables depending on the OS
{% if grains['os_family'] == 'RedHat' %}
apache: httpd
git: git
{% elif grains['os_family'] == 'Debian' %}
apache: apache2
git: git-core
{% else %}
apache: unknown
git: unknown
{% endif %}
