{ config, ... }:

let
  # Data directories
  configDir = "/home/nasuser/docker-volumes";
in {
  # Code-Server - VS Code in the browser
  virtualisation.oci-containers.containers.code-server = {
    image = "codercom/code-server:latest";
    ports = ["8080:8080"];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "${configDir}/code-server:/root/.config/code-server"
      "/home/nasuser/development:/root/project"  # Adjust the user path as needed
    ];
    environment = {
    };
    extraOptions = [
      "--user=root"
    ];
  };
}
