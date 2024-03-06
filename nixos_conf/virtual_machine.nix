{ ... }:
{
    virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
    };

    users.extraGroups.vboxusers.members = [ "toastielad" ];

    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "toastielad" ];
}
