#!/bin/bash

filename="/usr/share/novnc/app/ui.js"

find="var path = UI.getSetting('path');"
replace="var path = window.location.pathname.slice(1) + UI.getSetting('path');"
sed -i "s/$find/$replace/g" $filename

find="var autoconnect = WebUtil.getConfigVar('autoconnect', false);"
replace="var autoconnect = WebUtil.getConfigVar('autoconnect', true);"
sed -i "s/$find/$replace/g" $filename
