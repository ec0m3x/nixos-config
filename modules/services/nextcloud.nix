{ pkgs
, ...
}:{
  services = {                            # Nextcloud
    nextcloud-client = {                  
        enable = true;                  
    };
  };
}