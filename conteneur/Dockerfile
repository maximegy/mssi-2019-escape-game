FROM lukaszlach/kali-desktop:xfce

LABEL version="10"
LABEL from="lukaszlach/kali-desktop"
LABEL maintainer="Maxime VINCENT"

RUN apt update

# Escape program use figlet
RUN apt install -y vim figlet
COPY --chown=root:root config/figlet/* /usr/share/figlet/

# COPY bashrc for chat
COPY config/bashrc/kali-bashrc /home/kali/.bashrc
COPY --chown=root:root config/bashrc/root-bashrc /root/.bashrc

# COPY Desktop - terminal - panel theme for kali
# desactivate menu, taskbar, icons...
COPY config/theme/kali/.config/terminal /home/kali/.config/
COPY config/theme/kali/.config/xfce4/xfconf/xfce-perchannel-xml/* /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/

# COPY vnc passwd and configuration to secure VNC session
COPY --chown=root:root config/vnc/run /etc/services.d/x11vnc/run
COPY config/vnc/passwd /home/kali/.vnc/passwd

# COPY escape game code
COPY ./escape /home/kali/

RUN chown -R kali:kali /home/kali/.bashrc && \
    chown -R kali:kali /home/kali/.config && \
    chown -R kali:kali /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml && \
    chown -R kali:kali /home/kali/.vnc/passwd && \
    chown -R kali:kali /home/kali/escape