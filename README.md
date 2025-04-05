# 📦 Автоматический скрипт установки и запуска rl-swarm на серверах с GPU

🔹 Проверяет и устанавливает все необходимые системные пакеты (Python, Node.js, Yarn и др.)

🔹 Клонирует репозиторий rl-swarm

🔹 Обновляет package.json в modal-login с зафиксированной версией библиотеки viem@2.22.6

🔹 Устанавливает зависимости через yarn

🔹 Создаёт Python virtual environment

🔹 Запускает run_rl_swarm.sh в отдельной tmux-сессии

🔹 Разворачивает среду Ngrok в которой надо вставить ваш ключ, затем перейти по ссылке которую сгенерирует и зарегистрироваться в тестнете (везде будут подсказки)

## ⚙️ Используйте этот скрипт для быстрого развертывания и запуска проекта на новом сервере.

### 🇬🇧 Description

🔹 Checks and installs all required system packages (Python, Node.js, Yarn, etc.)

🔹 Clones the rl-swarm repository

🔹 Rewrites the modal-login/package.json with a locked version of viem@2.22.6

🔹 Installs dependencies via yarn

🔹 Creates a Python virtual environment

🔹 Starts run_rl_swarm.sh in a separate tmux session

🔹 The NGROK environment unfolds in which you need to insert your key, then follow the link that will generate and register in the twist (there will be hints everywhere)

## ⚙️ Use this script for quick deployment and startup of the project on a new server.

```Bash
git clone https://github.com/noderguru/Gensyn-Node-GPU_setup.git
```
```Bash
cd Gensyn-Node-GPU_setup && chmod +x Gensyn_full_Install.sh && ./Gensyn_full_Install.sh
```
!!! НЕ ЗАБУДЬТЕ !!! сохранить файл ```swarm.pem``` в папке rl-swarm и два файла ```userApiKey.json``` ```userData.json``` находятся тут rl-swarm/modal-login/temp-data/


