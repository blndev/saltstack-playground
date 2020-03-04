{% for usr in ['moe','larry','curly'] %}
create {{ usr }}:
  user.present:
    - name: {{ usr }}
    # create password hash with: openssl passwd -1
    # password here is 12345
    - password: "$1$rgBqDOwl$rJsve1FIEeYxSB6SdPt1w."
{% endfor %}