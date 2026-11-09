#!/usr/bin/env bash
# Ajusta o projeto Android gerado pelo Capacitor: ícone e orientação.
set -euo pipefail

MANIFEST="android/app/src/main/AndroidManifest.xml"
RES="android/app/src/main/res"

# --- Ícone do app (usa icon-512.png sem redimensionar) ---
ICON="www/assets/icon-512.png"
rm -rf "$RES"/mipmap-anydpi-v26
for d in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
  mkdir -p "$RES/mipmap-$d"
  cp "$ICON" "$RES/mipmap-$d/ic_launcher.png"
  cp "$ICON" "$RES/mipmap-$d/ic_launcher_round.png"
  cp "$ICON" "$RES/mipmap-$d/ic_launcher_foreground.png"
done

# --- Tela sempre em pé ---
python3 - "$MANIFEST" <<'PY'
import sys
p = sys.argv[1]
s = open(p, encoding="utf-8").read()
if "screenOrientation" not in s:
    s = s.replace('android:name=".MainActivity"', 'android:name=".MainActivity"\n            android:screenOrientation="portrait"', 1)
open(p, "w", encoding="utf-8").write(s)
PY

echo "Projeto Android ajustado."
