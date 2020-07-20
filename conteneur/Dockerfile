FROM lukaszlach/kali-desktop:xfce

LABEL version="10"
LABEL from="lukaszlach/kali-desktop"
LABEL maintainer="Maxime VINCENT"

RUN apt update

# Escape program use figlet
RUN apt install -y vim figlet eog
COPY --chown=root:root config/figlet/* /usr/share/figlet/

# COPY bashrc for chat
COPY --chown=1000:1000 config/bashrc/kali-bashrc /home/kali/.bashrc
COPY --chown=root:root config/bashrc/root-bashrc /root/.bashrc

# COPY Desktop - terminal - panel theme for kali
# desactivate menu, taskbar, icons...
COPY --chown=1000:1000 config/theme/kali/.config/xfce4/terminal /home/kali/.config/terminal
COPY --chown=1000:1000 config/theme/kali/.config/xfce4/xfconf/xfce-perchannel-xml/* /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/

# COPY vnc passwd and configuration to secure VNC session
COPY --chown=root:root config/vnc/run /etc/services.d/x11vnc/run
COPY --chown=1000:1000 config/vnc/passwd /home/kali/.vnc/passwd

# COPY escape game code
COPY --chown=1000:1000 ./escape /home/kali/