# Домашнее задание к занятию "`Использование Ansible`" - `Татаринцев Алексей`

export TF_CLI_CONFIG_FILE=./terraformrc
---

### Задание 1

1. `Весь проект разворачивается через Terraform`
2. `Создает 3 ВМ в яндекс облаке , в данном случае с следующими ip`
```
clickhouse_ip = "89.169.154.4"
lighthouse_ip = "89.169.153.110"
vector_ip = "89.169.129.124"
```
![1](https://github.com/Foxbeerxxx/use_ansible/blob/main/img/img1.png)

3. `Далее идем по заданию`
4. `Создаем prod.yml с содержимым`
```
all:
  children:
    lighthouse:
      hosts:
        lh01:
          ansible_host: 89.169.149.95

```
5. `Выполняю  ansible-lint site.yml и получаю гору ошибок, провожу траблшутинг`

```
site.yml:36 Task/Handler: Configure nginx for Lighthouse

fqcn[action-core]: Use FQCN for builtin module actions (file).
site.yml:42 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (file).
site.yml:48 Use `ansible.builtin.file` or `ansible.legacy.file` instead.

fqcn[action-core]: Use FQCN for builtin module actions (service).
site.yml:53 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

fqcn[action-core]: Use FQCN for builtin module actions (service).
site.yml:60 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

Read documentation for instructions on how to ignore specific rule violations.

                    Rule Violation Summary                    
 count tag                    profile    rule associated tags 
     1 yaml[truthy]           basic      formatting, yaml     
     1 risky-file-permissions safety     unpredictability     
     9 fqcn[action-core]      production formatting           

Failed: 11 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
alexey@dellalexey:~/ansible_new/use_ansible$ 
     9 fqcn[action-core]      production formatting           

Failed: 11 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
alexey@dellalexey:~/ansible_new/use_ansible$ 

fqcn[action-core]: Use FQCN for builtin module actions (service).
site.yml:53 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

fqcn[action-core]: Use FQCN for builtin module actions (service).
site.yml:60 Use `ansible.builtin.service` or `ansible.legacy.service` instead.

Read documentation for instructions on how to ignore specific rule violations.

                    Rule Violation Summary                    
 count tag                    profile    rule associated tags 
     1 yaml[truthy]           basic      formatting, yaml     
     1 risky-file-permissions safety     unpredictability     
     9 fqcn[action-core]      production formatting           

Failed: 11 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.ria was 'min'.

```

6. `Снова пробую ansible-lint site.yml и получаю итог` 

![2](https://github.com/Foxbeerxxx/use_ansible/blob/main/img/img2.png)

7. `Запускаю ansible-playbook -i prod.yml site.yml --check`

![3](https://github.com/Foxbeerxxx/use_ansible/blob/main/img/img3.png)

8. `Затем ansible-playbook -i prod.yml site.yml --diff`
```
Вывод
alexey@dellalexey:~/ansible_new/use_ansible$ ansible-playbook -i prod.yml site.yml --diff

PLAY [Deploy Lighthouse static UI] ************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************
[WARNING]: Platform linux on host lighthouse-01 is using the discovered Python interpreter at /usr/bin/python3.12, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [lighthouse-01]

TASK [Install dependencies] *******************************************************************************************************
The following additional packages will be installed:
  nginx-common
Suggested packages:
  fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  nginx nginx-common
0 upgraded, 2 newly installed, 0 to remove and 12 not upgraded.
changed: [lighthouse-01]

TASK [Download Lighthouse static archive] *****************************************************************************************
changed: [lighthouse-01]

TASK [Ensure /var/www exists] *****************************************************************************************************
ok: [lighthouse-01]

TASK [Ensure destination dir exists] **********************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/var/www/lighthouse",
-    "state": "absent"
+    "state": "directory"
 }

changed: [lighthouse-01]

TASK [Extract Lighthouse archive] *************************************************************************************************
changed: [lighthouse-01]

TASK [Configure nginx for Lighthouse] *********************************************************************************************
--- before
+++ after: /home/alexey/.ansible/tmp/ansible-local-41046lpqjqd05/tmpc1s2wv6n/lighthouse_nginx.conf.j2
@@ -0,0 +1,11 @@
+server {
+    listen 80;
+    server_name _;
+
+    root /var/www/lighthouse/lighthouse-master;
+    index index.html;
+
+    location / {
+        try_files $uri $uri/ /index.html =404;
+    }
+}

changed: [lighthouse-01]

TASK [Enable nginx site] **********************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/etc/nginx/sites-enabled/lighthouse.conf",
-    "state": "absent"
+    "state": "link"
 }

changed: [lighthouse-01]

TASK [Disable default site] *******************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/etc/nginx/sites-enabled/default",
-    "state": "link"
+    "state": "absent"
 }

changed: [lighthouse-01]

TASK [Ensure nginx is running] ****************************************************************************************************
ok: [lighthouse-01]

RUNNING HANDLER [Reload nginx] ****************************************************************************************************
changed: [lighthouse-01]

PLAY RECAP ************************************************************************************************************************
lighthouse-01              : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

9. `Повторно запускаю ansible-playbook -i prod.yml site.yml --diff и убеждаюсь что они идемпотентен `

![4](https://github.com/Foxbeerxxx/use_ansible/blob/main/img/img4.png)

