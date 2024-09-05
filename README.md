## Part 1. Ready-made docker

### Пуллим образ контейнера `nginx`

![docker pull nginx](screenshots/Part_1_1.png)

### Проверяем чтобы образ точно установился

![docker ps](screenshots/Part_1_2.png)

### Запускаем контейнер

![docker run](screenshots/Part_1_3.png)

### Проверяем что контейнер работает

![docker ps](screenshots/Part_1_4.png)

### Результат работы `docker inspect`

![docker inspect](screenshots/Part_1_5.png)

![docker inspect](screenshots/Part_1_9.png)

* `Размер контейнера` - `187707974` байт
* `Замапленные порты` - `:80` на `:80`
* `Айпи контейнера` - `172.17.0.2`

### Останавливаем работающий контейнер

![docker stop](screenshots/Part_1_7.png)

### Проверяем что контейнер действительно остановился

![docker stop](screenshots/Part_1_8.png)


### Запускаем контейнер снова с замапленными портами `80` и `443`

![docker run](screenshots/Part_1_10.png)

### Заходим на `localhost:80`

![docker run](screenshots/Part_1_11.png)

### Перезапускаем контейнер командой `docker restart`

![docker restart](screenshots/Part_1_12.png)

### Проверяем что контейнер работает

![docker restart](screenshots/Part_1_13.png)

## Part 2. Operations with container

### Читаем конфигурацию `nginx.conf` внутри контейнера

![nginx](screenshots/Part_2_1.png)

### Создаем конфигурацию `nginx.conf` на локальной машине и настраиваем её на показ `/status`

![nginx](screenshots/Part_2_2.png)

![nginx_conf](screenshots/Part_2_3.png)


### Локально проверяем работу конфигурации, заходим на `localhost:80/status`

![nginx_conf](screenshots/Part_2_4.png)

### Копируем конфигурацию в docker контейнер и перезапускаем nginx внутри него

![docker cp](screenshots/Part_2_5.png)

### Проверяем localhost/status

![docker cp](screenshots/Part_2_6.png)

### Экспортируем контейнер

![docker export](screenshots/Part_2_7.png)

### Останавливаем контейнер

![docker stop](screenshots/Part_2_8.png)

### Удаляем образ контейнера nginx с флагом `-f`

![docker rmi](screenshots/Part_2_9.png)

### Удаляем контейнер

![docker rm](screenshots/Part_2_10.png)


### Импортируем контейнер обратно

![docker import](screenshots/Part_2_11.png)

![docker image ls](screenshots/Part_2_12.png)

### Запускаем импортированный контейнер

![docker run](screenshots/Part_2_13.png)

### Проверяем что контейнер работает

![docker run](screenshots/Part_2_14.png)


## Part 3. Mini web server

### Пишем небольшой сервер с FCGI который будет возвращать нам Hello World

![fcgi](screenshots/Part_3_1.png)

### Вносим необходимые правки в конфигурацию nginx и меняем её

![nginx_edit](screenshots/Part_3_2.png)

![nginx_edit](screenshots/Part_3_3.png)

### Перезапускаем nginx и запускаем сервер через `spawn-fcgi`

![nginx_launch](screenshots/Part_3_4.png)

### Заходим на `localhost:81` и проверяем результат

![nginx_test](screenshots/Part_3_5.png)

### Перемещаем nginx.conf в `./nginx/nginx.conf`

![nginx_conf](screenshots/Part_3_6.png)

## Part 4. Your own docker

### Пишем `build.sh` который на моменте сборки будет подготавливать контейнер к работе и компилировать сервер внутри него

![build.sh](screenshots/Part_4_1.png)

### Dockerfile для сборки контейнера:

![dockerfile](screenshots/Part_4_2.png)

### Запускаем сборку с именем и тегом

![dockerfile](screenshots/Part_4_3.png)

![docker](screenshots/Part_4_4.png)

### Проверяем что образ успешно сбилдился

![docker_build](screenshots/Part_4_5.png)

### Создаем и запускаем контейнер с пробросом порта 81 на наш 80

![docker_image_create](screenshots/Part_4_6.png)

### Проверяем localhost:80

![docker_image_create](screenshots/Part_4_7.png)

### В конфиге nginx контейнера уже есть проксирование на /status, но бросим его туда еще раз, как и говорит задание

![docker_status](screenshots/Part_4_8.png)

### Перезапускаем контейнер

![docker_restart](screenshots/Part_4_9.png)

### Проверяем `localhost:80/status`

![localhost_status](screenshots/Part_4_10.png)

## Part 5. Dockle

### Тестово запускаем dockly на текущей версии контейнера

![dockle](screenshots/Part_5_0.jpg)

### Меняем конфигурацию `dockerfile`:

![dockerfile](screenshots/Part_5_1.png)

### Билдим с `DOCKER_CONTENT_TRUST=1`

![docker_build](screenshots/Part_5_2.png)

### Проверяем что контейнер успешно собрался

![docker_build](screenshots/Part_5_3.png)

### Проверяем контейнер через `dockle`

![dockle](screenshots/Part_5_4.png)

### Запускаем контейнер

![dockle](screenshots/Part_5_5.png)

### Проверяем localhost:80

![dockle](screenshots/Part_5_6.png)

**Что было сделано:**

* Смена основого пользователя контейнера на с `root` на `nginx` с добавлением всех необходимых для работы nginx и fcgi прав пользователю.
* Добавление `healthcheck` для проверки работоспособности контейнера, основывающегося на проверке работоспособности процесса `spawn-fcgi`
* Добавление флага `-ak` (acknowledge keys) для  `NGINX_GPGKEYS` `NGINX_GPGKEY_PATH`, которые являются переменными инит-скрипта для официального контейнера nginx на основе которого работает мой. Эти переменные хранят в себе публичные ключи для проверки подписи образов nginx и их наличие в контейнере не является угрозой безопасности.
* Добавление env-переменной `DOCKER_CONTENT_TRUST=1` при сборке и проверке образа.
* Удаление `setuid` и `setgid` разрешений для служебных файлов.
* Смена тега образа c `latest` на `v1` при сборке образа.


## Part 6. Basic Docker Compose

### Пишем `docker-compose.yml`

![docker-compose.yml](screenshots/Part_6_1.png)

### Создаем дополнительный конфиг для шлюза (`nginx`)

![docker-compose.yml](screenshots/Part_6_2.png)

### Собираем получившуюся вундервафлю через `docker-compose build`

![docker-compose.yml](screenshots/Part_6_3.png)

### Останавливаем все работающие контейнеры

![docker-compose.yml](screenshots/Part_6_4.png)

### Запускаем через `docker-compose up`

![docker-compose.yml](screenshots/Part_6_5.png)

### Заходим на `localhost:80`

![docker-compose.yml](screenshots/Part_6_6.png)