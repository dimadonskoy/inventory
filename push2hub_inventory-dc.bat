@echo off

docker login -u crooper22@gmail.com

docker tag inventory-docker-compose-app crooper/web-apps-verifone:inventory-dc

docker push crooper/web-apps-verifone:inventory-dc

pause