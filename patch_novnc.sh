#!/bin/bash

filename="/usr/share/novnc/app/ui.js"

find="UI.initSetting('path', 'websockify');"
replace="UI.initSetting('path', window.location.pathname.slice(1) + 'websockify');"
sed -i "s/$find/$replace/g" $filename

find="var autoconnect = WebUtil.getConfigVar('autoconnect', false);"
replace="var autoconnect = WebUtil.getConfigVar('autoconnect', true);"
sed -i "s/$find/$replace/g" $filename
