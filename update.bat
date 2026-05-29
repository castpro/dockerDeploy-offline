@echo off
echo === 로컬 서버 업데이트 시작 ===

cd /d C:\local-server\evc_was
git pull origin hdc

cd /d C:\local-server\ocpp
git pull origin offline_deploy

cd /d C:\local-server\evc_webadmin
git pull origin local-deploy

cd /d C:\local-server\dockerDeploy-offline
git pull origin main
docker-compose down
docker-compose up -d --build

echo === 업데이트 완료 ===
pause
