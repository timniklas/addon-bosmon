#!/bin/bash

filename="/usr/share/novnc/app/ui.js"

find="UI.initSetting('path', 'var path = UI.getSetting('path');"
replace="UI.initSetting('path', 'var path = window.location.pathname.slice(1) + UI.getSetting('path');"
sed -i "s/$find/$replace/g" $filename

find="var autoconnect = WebUtil.getConfigVar('autoconnect', false);"
replace="var autoconnect = WebUtil.getConfigVar('autoconnect', true);"
sed -i "s/$find/$replace/g" $filename
