{ config, pkgs, ... }:

{
  services.homepage-dashboard = {
    enable = true;
    settings = {
      title = "Sencha";
    };
    services = [
      {
        Services = [
          {
            Gitea = {
              href = "https://g.sc";
              icon = "gitea";
            };
          }
          {
            CodeEditor = {
              href = "https://g.sc";
              icon = "vscode";
            };
          }
        ];
      }
      {
        Utilities = [
          {
            LLDAP = {
              href = "https://ld";
            };
          }

        ];
      }
      {
        Multimedia = [
          {
            Jellyfin = {
              icon = "jellyfin";
              href = "https://jellyfi";
            };
          }
        ];
      }
    ];
    bookmarks = [
      {
        Developer = [
          {
            Github = [{
              icon = "si-github";
              href = "https://github.com/";
            }];
          }
          {
            "Nixos Search" = [{
              icon = "si-nixos";
              href = "https://search.nixos.org/packages";
            }];
          }
          {
            "Nixos Wiki" = [{
              icon = "si-nixos";
              href = "https://nixos.wiki/";
            }];
          }
          {
            "Kubernetes Docs" = [{
              icon = "si-kubernetes";
              href = "https://kubernetes.io/docs/home/";
            }];
          }
        ];
      }
    ];
    widgets = [
        {
          datetime = {
            format = {
              dateStyle = "short";
              timeStyle = "short";
            };
          };
        }
        {
          search = {
            provider = "duckduckgo";
            focus = true;
            showSearchSuggestions = true;
            target = "self";
          };
        }
        {
          resources = {
            cpu = true;
            cputemp = true;
            memory = true;
            units = "metric";
            tempmin = 0;
            tempmax = 100;
            refresh = 50000;
            expanded = true;
          };
        }
      ];
  };
}