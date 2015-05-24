#Windows Installationsroutine für Ing.Inform Entwicklungsumgebung
Alles was benötigt wird um eine Installationsroutine für die Ing.Inform Entwicklungsumgebung (IIF-DevEnv) zu erstellen:

- **Sammler-Image:** Ein Docker Image welches benutzt werden kann um alle benötigten Komponenten der IIF-DevEnv in der passenden Version auf den Build-Rechner zu laden.
- **IIF-DevEnv-Wix-Projekt:** Der Quellcode zur Erstellung der Installationsroutine für das WiX-Toolset
- **Bash-Skripte:** Einige bash Skripte die das Erstellen der Installationsroutine vereinfachen.

## IIF-DevEnv.msi
Hiermit werden einzelne Dateien (wie z.B. docker.exe) auf den Zielrechner kopiert. Dies wird gemacht weil es für die Dateien keine eigenständige Installationsroutine gibt. Zusätzlich werden noch Skripte zum starten und stoppen der Entwicklungsumgebung bereit gestellt.

### Das MSI erstellen
Um das MSI erstellen zu können wird ein Container vom Image `suchja/wix` benötigt. Um das MSI auch gleich testen zu können ist es hilfreich den Container mit einem laufenden Container vom Image `suchja/x11server` zu verlinken. Am besten wird dazu `docker-compose.yml` verwendet. Einfach im Verzeichnis den DisplayServer starten:

`docker-compose up -d`

und dann den Container mit wix starten:

`docker-compose run Wix /bin/bash`

Nachdem alle Container laufen und Du im Wix Container bist, kannst Du mit den folgenden Befehlen das MSI aus den Quellen erstellen:

```
wine ../wix/candle.exe -o build/iif-devenv.wixobj iif-devenf.wxs
wine ../wix/light.exe -o build/iif-devenv.mis -sval build/iif-devenv.wixobj
```

Abschliessend kannst Du das erstellte msi direkt im wine prefix zum testen installieren: `wine msiexec /i build/iif-devenv.msi`. Über `wine uninstaller` kannst Du sehen welche Einträge in "Programs and Features" gemacht werden. Dort sollte das Setup nun zu sehen sein. Mit `winefile` kannst Du eine Art Explorer öffnen mit dem Du schauen kannst ob die Dateien an die richtige Stelle installiert wurden.
