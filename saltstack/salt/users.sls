{% for usr in ['moe','larry','curly'] %}
create {{ usr }}:
  user.present:
    # details: https://docs.saltstack.com/en/master/ref/states/all/salt.states.user.html
    - name: {{ usr }}
    # create password hash with: openssl passwd -1
    # password here is 12345
    - password: "$1$rgBqDOwl$rJsve1FIEeYxSB6SdPt1w."
{% endfor %}

# If a Password is set it will always be overwritten on state apply