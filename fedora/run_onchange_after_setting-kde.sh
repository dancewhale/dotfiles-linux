#!/usr/bin/env sh

kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""

qdbus org.kde.KWin /KWin reconfigure
