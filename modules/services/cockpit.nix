{ ... }:

{
  services.cockpit = {
    enable = true;
    openFirewall = true;
  };

  environment.etc."cockpit/disallow-write.json" = {
    text = ''
      {
        "groups": {
          "all": {
            "color": "#d3d7cf",
            "features": ["feature-read"],
            "matches": [{"kind": "user"}],
            "policy": {"*": {"*": {"*": {"allow": [{"permission": "read"}]}}}}
          }
        }
      }
    '';
    mode = "0644";
  };
}