import "chameleon" as chameleon;

export const colors = chameleon::theme;

export let eggs = #{
    waybar: #{
        targets: "~/.config/waybar",
        templates: ["style.css"],
        enabled: true,
    },
    wofi: #{
        targets: "~/.config/wofi",
        templates: ["style.css"],
        enabled: true,
    },
    rmpc: #{
        targets: "~/.config/rmpc",
        templates: ["themes/chameleon.ron"],
        enabled: true,
    },
};
