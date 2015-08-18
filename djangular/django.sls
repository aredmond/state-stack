python-pip:
  pkg.installed

virtualenvwrapper:
  pip.installed:
    - require:
      - pkg: python-pip

django:
  pip.installed:
    - name: django >= 1.8
    - require:
      - pkg: python-pip
git:
  pkg.installed

#https://github.com/saltstack/salt.git:
#  git.latest:
#    - rev: develop
#    - target: /tmp/salt

git-test:
  git.latest:
    - name: https://github.com/aredmond/custom_configs.git
    - rev: master
    - target: /root/configs
    - require:
        - pkg: git
