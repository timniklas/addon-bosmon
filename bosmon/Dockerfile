# Use an official Ubuntu base image
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# Updates packages
RUN apt-get update

# Install XFCE, VNC server, dbus-x11, and xfonts-base, wget
RUN apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    xfonts-base \
    wget

# update ca certificates
RUN apt-get install ca-certificates -y

# Add wine repo
RUN dpkg --add-architecture i386 && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt-get update

# Install Wine, Winetricks, Mono
RUN apt-get install --install-recommends winehq-stable winetricks -y

# Install Xvfb, Xte
RUN apt-get install xvfb xautomation -y

# Install .NET 4.7.2    
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks
RUN WINEARCH=win32 ./winetricks -q dotnet472

# Install webview
RUN wget -O webview_setup.exe https://go.microsoft.com/fwlink/p/?LinkId=2124703
RUN xvfb-run wine webview_setup.exe && rm webview_setup.exe

# Install novnc
RUN apt-get -y install novnc python3-websockify tigervnc-standalone-server tigervnc-xorg-extension
RUN cp /usr/share/novnc/vnc_auto.html /usr/share/novnc/index.html

# clean up installers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup VNC server
RUN mkdir /root/.vnc \
    && echo "BosMon" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Set display resolution (change as needed)
ENV RESOLUTION=1920x1080

# Expose noVNC port
EXPOSE 7281

# Set the working directory in the container
WORKDIR /app

# Define BosMon volume
VOLUME ["/root/.wine/drive_c/users/root/AppData/Roaming/BosMon"]
VOLUME ["/root/.wine/drive_c/Program Files/BosMon"]

# Copy Bosmon
RUN wget -O bosmon_setup.exe https://www.bosmon.de/files/bosmon_setup_2023_11.exe
COPY install_bosmon.sh install_bosmon.sh
RUN chmod +x install_bosmon.sh

# Copy a script to start the VNC server
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh
COPY startup.sh /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

#DEBUG
ENV KEY_NAME="Tim Tester2"
ENV KEY_SERIAL="YA1QWI7JBBBEE572BPDC6RTAM"

ENTRYPOINT ["/app/start-vnc.sh"]
