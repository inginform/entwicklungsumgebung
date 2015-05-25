#Windows Installationsroutine für Ing.Inform Entwicklungsumgebung
Alles was benötigt wird um eine Installationsroutine für die Ing.Inform Entwicklungsumgebung (IIF-DevEnv) zu erstellen. Als finales Resultat wird die `iif-devenv-setup.exe` erstellt. Dazu werden folgende Komponenten verwendet:

- **Sammler-Image:** Ein Docker Image welches benutzt werden kann um alle benötigten Komponenten der IIF-DevEnv in der passenden Version auf den Build-Rechner zu laden. [Weitere Details](Sammler/README.md)
- **IIF-DevEnv-Wix-Projekt:** Der Quellcode zur Erstellung der Installationsroutine für das WiX-Toolset. Es besteht aus der Quelldatei `iif-devenv.wxs` welche eine MSI beschreibt. Darin sind die Docker Bestandteile und einige Skripte enthalten. Weiterhin gibt es die Quelldatei `iif-devenv-bundle.wxs` welche eine Setup.exe beschreibt. Hiermit werden die Anwendungen mit eigener Installationsroutine installiert und das IIF spezifische MSI.
- **Bash-Skripte:** Einige bash Skripte die das Erstellen der Installationsroutine vereinfachen.

## Verwendung
Zum kompletten erstellen des Setups kann einfach das Skript `build.sh` mit dem Option `all` aufgerufen werden (also `./build.sh all`). Dieses Skript startet das laden der benötigten Programme und lässt dann sowohl das `iif-devenv.msi` wie auch die `iif-devenv-setup.exe` bauen.

Als weitere Option hat das selbe Skript noch `setup`. Durch diese Option wird das laden der benötigten Programme weg gelassen. Dies ist eh nur nötig, wenn entweder neue Versionen verwendet werden, oder wenn das Setup auf einem Rechner erstellt wird auf dem die Programme noch nicht geladen wurden.

# Detailbeschreibung
## IIF-DevEnv.msi
Hiermit werden einzelne Dateien (wie z.B. docker.exe) auf den Zielrechner kopiert. Dies wird gemacht weil es für die Dateien keine eigenständige Installationsroutine gibt. Zusätzlich werden noch Skripte zum starten und stoppen der Entwicklungsumgebung bereit gestellt.

### Das MSI erstellen
Um das MSI erstellen zu können wird ein Container vom Image `suchja/wix` benötigt. Um das MSI auch gleich testen zu können ist es hilfreich den Container mit einem laufenden Container vom Image `suchja/x11server` zu verlinken. Am besten wird dazu `docker-compose.yml` verwendet. Durch die Angaben in dieser Datei können einfach beide Container (einer mir X11Server und einer mit Wix) gestartet werden. Dazu braucht bloß folgendes Kommando eingegeben werden:

`docker-compose run Wix /bin/bash`

Nachdem alle Container laufen und Du im Wix Container bist, kannst Du mit den folgenden Befehlen das MSI aus den Quellen erstellen:

```
wine ../wix/candle.exe -o build/iif-devenv.wixobj iif-devenv.wxs
wine ../wix/light.exe -o build/iif-devenv.msi -sval build/iif-devenv.wixobj
```

Abschliessend kannst Du das erstellte msi direkt im wine prefix zum testen installieren: `wine msiexec /i build/iif-devenv.msi`. Über `wine uninstaller` kannst Du sehen welche Einträge in "Programs and Features" gemacht werden. Dort sollte das Setup nun zu sehen sein. Mit `winefile` kannst Du eine Art Explorer öffnen mit dem Du schauen kannst ob die Dateien an die richtige Stelle installiert wurden.

Nachdem das MSI fertig und getestet ist, kann mit `docker-compose stop` der noch laufende X11Server gestoppt werden. Danach sollten noch die gestoppten Container gelöscht werden, wenn sie nicht wieder benötigt werden.

## IIF-DevEnv-Setup.exe
Im Jargon von WiX Toolset wird dies als Bootstrap Application bezeichnet. Es handelt sich dabei um eine Datei die alle Setups enthält und diese nach der vorgegebenen Reihenfolge installiert. 