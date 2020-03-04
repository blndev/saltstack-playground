deploy the http.conf file:
  file.managed:
    - name: /tmp/iwashere.log
    - source: salt://testdata/hello_world.txt


copy some files to the web server:
  file.recurse:
    - name: /tmp/www
    - source: salt://demo/nginx
