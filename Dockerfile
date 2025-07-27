# Use an official Ubuntu base image
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# Updates packages
RUN apt-get update

# Install XFCE, VNC server, dbus-x11, and xfonts-base, wget, Xvfb, Xte, jq
RUN apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xfwm4 \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    dbus-x11 \
    xfonts-base \
    wget \
    curl \
    xvfb \
    xautomation \
    cabextract \
    jq

# update ca certificates
RUN apt-get install ca-certificates -y

# Install Wine
RUN dpkg --add-architecture i386 && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt-get update \
    && apt-get install --install-recommends winehq-stable -y

# Install .NET
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks
RUN WINEARCH=win32 ./winetricks -q dotnet472

# Install fontfix
RUN WINEARCH=win32 ./winetricks -q fontfix

# Install webview
RUN wget -O webview_setup.exe https://go.microsoft.com/fwlink/p/?LinkId=2124703
RUN xvfb-run wine webview_setup.exe && rm webview_setup.exe

# Install TTS
RUN xvfb-run wget https://download.microsoft.com/download/A/6/4/A64012D6-D56F-4E58-85E3-531E56ABC0E6/x86_SpeechPlatformRuntime/SpeechPlatformRuntime.msi
RUN xvfb-run wine msiexec /i SpeechPlatformRuntime.msi
RUN xvfb-run wget https://download.microsoft.com/download/4/0/D/40D6347A-AFA5-417D-A9BB-173D937BEED4/MSSpeech_TTS_de-DE_Hedda.msi
RUN xvfb-run wine msiexec /i MSSpeech_TTS_de-DE_Hedda.msi
RUN WINEARCH=win32 ./winetricks msxml6

# Install novnc
RUN apt-get -y install novnc python3-websockify
COPY patch_novnc.sh patch_novnc.sh
RUN chmod +x patch_novnc.sh && ./patch_novnc.sh && rm patch_novnc.sh
RUN cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# clean up installers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup VNC server
RUN mkdir /root/.vnc \
    && echo "BosMon" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Set the working directory in the container
WORKDIR /app

# Copy Bosmon
RUN wget -O bosmon_setup.exe https://www.bosmon.de/files/bosmon_setup_2023_15_1.exe
COPY install_bosmon.sh install_bosmon.sh
RUN chmod +x install_bosmon.sh \
    && xvfb-run ./install_bosmon.sh \
    && rm -f install_bosmon.sh \
    && rm -f bosmon_setup.exe

# Copy a script to start the VNC server
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh
COPY xstartup.sh /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

HEALTHCHECK --interval=5s \
  CMD pgrep -f "BosMon.exe" || exit 1

ENTRYPOINT ["/app/start-vnc.sh"]
