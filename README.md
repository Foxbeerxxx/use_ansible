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

8. `Заполните здесь этапы выполнения, если требуется ....`
9. `Заполните здесь этапы выполнения, если требуется ....`
10. `Заполните здесь этапы выполнения, если требуется ....`
11. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 2](ссылка на скриншот 2)`


---

### Задание 3

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`

### Задание 4

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
