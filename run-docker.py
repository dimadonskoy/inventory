import subprocess
import pwinput

# Variables
docker_image = "crooper/web-apps-verifone:inventory"
container_name = "inventory"
host_port = "5000"
container_port = "80"
docker_username = "crooper22@gmail.com"
docker_password = pwinput.pwinput(prompt='DockerHub password : ', mask='*' )


def run_command(command):
    """Run a shell command and print its output."""
    try:
        result = subprocess.run(command, shell=True,
                                check=True, text=True, capture_output=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e.stderr}")


# Authenticate with Docker Hub
print("Authenticating with Docker Hub...")
try:
    login_command = f"echo {docker_password} | docker login --username {docker_username} --password-stdin"
    run_command(login_command)
except Exception as e:
    print(f"Failed to authenticate: {e}")
    exit(1)

# Pull the image from Docker Hub
print("Pulling image from Docker Hub...")
run_command(f"docker pull {docker_image}")

# Check if the container already exists
print("Checking for existing container...")
existing_container = subprocess.run(
    f"docker ps -aq --filter name={container_name}",
    shell=True,
    check=False,
    text=True,
    capture_output=True,
).stdout.strip()

if existing_container:
    print(f"Removing existing container: {container_name}")
    run_command(f"docker rm -f {container_name}")

# Run the container with restart policy set to always
print(f"Starting the container: {container_name}")
run_command(
    f"docker run -d "
    f"--name {container_name} "
    f"-p {host_port}:{container_port} "
    f"--restart=always "
    f"{docker_image}"
)

# Confirm the container is running
print(f"Container {container_name} is now running.")
run_command(f"docker ps --filter name={container_name}")
