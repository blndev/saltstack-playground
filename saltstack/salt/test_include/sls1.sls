list local directory:
  cmd.run:
    - name: ls -la
    - require:
      - sls: test_include.sls2


# A:
#   cmd.run:
#     - name: echo A
#     - require_any:
#       - cmd: B
#       - cmd: C
#       - cmd: D
# B:
#   cmd.run:
#     - name: echo B

# C:
#   cmd.run:
#     - name: /bin/false

# D:
#   cmd.run:
#     - name: echo D
