import subprocess

app_name = "inventory"

subprocess.run(f"docker build  --no-cache -t {app_name} .")