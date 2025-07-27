# Install webview
wget -O webview_setup.exe https://go.microsoft.com/fwlink/p/?LinkId=2124703
wine webview_setup.exe && rm webview_setup.exe

# Install TTS
wget https://download.microsoft.com/download/A/6/4/A64012D6-D56F-4E58-85E3-531E56ABC0E6/x86_SpeechPlatformRuntime/SpeechPlatformRuntime.msi
wine msiexec /i SpeechPlatformRuntime.msi
wget https://download.microsoft.com/download/4/0/D/40D6347A-AFA5-417D-A9BB-173D937BEED4/MSSpeech_TTS_de-DE_Hedda.msi
wine msiexec /i MSSpeech_TTS_de-DE_Hedda.msi
WINEARCH=win32 ./winetricks msxml6
