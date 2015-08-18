python-pip:
  pkg.installed

virtualenvwrapper:
  pip.installed:
    - require:
      - pkg: python-pip

djangular:
  user.present:
    - fullname: J Djangular
    - shell: /bin/bash
    - home: /home/djangular

git:
  pkg.installed

#https://github.com/saltstack/salt.git:
#  git.latest:
#    - rev: develop
#    - target: /tmp/salt

/home/djangular/repo:
  file.directory:
    - user: djangular
    - group: djangular
    - mode: 755
    - makedirs: True

/home/djangular/.cache:
  file.directory:
    - user: djangular
    - group: djangular
    - mode: 755
    - makedirs: True

git-djangular:
  git.latest:
    - name: https://github.com/aredmond/djangular.git 
    - rev: master
    - target: /home/djangular/repo
    - user: djangular
    - require:
        - pkg: git

/home/djangular/.env:
  file.directory:
    - user: djangular
    - group: djangular
    - mode: 755
    - makedirs: True

djangular-env:
  virtualenv.managed:
    - name: /home/djangular/.env/djangular
    - cwd: /home/djangular/.env/djangular
    - user: djangular
    - no_chown: false

djangular-reqs:
  pip.installed:
    - requirements: /home/djangular/repo/requirements.txt
    - bin_env: /home/djangular/.env/djangular
    - user: djangular
    - watch:
      - git: git-djangular

