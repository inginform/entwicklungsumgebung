#Windows Installationsroutine für Ing.Inform Entwicklungsumgebung
Alles was benötigt wird um eine Installationsroutine für die Ing.Inform Entwicklungsumgebung (IIF-DevEnv) zu erstellen:

- **Bundler-Image:** Ein Docker Image welches benutzt werden kann um alle benötigten Komponenten der IIF-DevEnv in der passenden Version auf den Build-Rechner zu laden.
- **Build-Image:** Ein Docker Image mit dem WiX-Toolset welches benutzt wird um die Installationsroutine (Setup.exe) zu bauen. Es wird das IIF-DevEnv-WiX-Projekt verwendet und die Komponenten die mithilfe des Bundler-Images geladen wurden.
- **IIF-DevEnv-Wix-Projekt:** Der Quellcode zur Erstellung der Installationsroutine für das WiX-Toolset