---
- hosts: client1,client2,client3

  tasks:
  - name: install httpd
    yum:
      name: httpd
      state: present

  - name: Install php
    yum:
      name: php56
      state: present

  - name: Install mysql
    yum:
      name: mysql55
      state: present

  - name: link php-mysql
    yum:
      name: php56-mysql55
      state: present