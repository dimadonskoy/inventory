@echo off

docker login -u crooper22@gmail.com

docker tag inventory crooper/web-apps-verifone:inventory

docker push crooper/web-apps-verifone:inventory

pause