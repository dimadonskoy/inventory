import subprocess
import pwinput

dockerhub_user = r'crooper22@gmail.com'
dockerhub_tag = r'crooper/web-apps-verifone:inventory'
dockerhub_push = r'crooper/web-apps-verifone:inventory'
docker_app_name = 'inventory'


docker_password = pwinput.pwinput(prompt='\nDockerHub password : ', mask='*' )  #### mask password ####

subprocess.run(["docker", "login", "-u", dockerhub_user, "--password-stdin"], input=docker_password, text=True, check=True)

subprocess.run(f"docker tag {docker_app_name} {dockerhub_tag}" , check=True ,shell=True)  

subprocess.run(f"docker push {dockerhub_push}", check=True , shell=True) 