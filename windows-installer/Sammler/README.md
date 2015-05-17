#Bestandteile der Ing.InForm Entwicklungsumgebung
Die Ing.InForm Entwicklungsumgebung basiert hauptsächlich auf bereits bestehenden Anwendungen. Ein Container basierend auf diesem Docker Image, lädt alle notwendigen Anwendungen aus dem Internet und legt sie lokal ab. Dabei wird darauf geachtet, dass von jeder Anwendung eine spezifische Version geladen wird. Somit wird ausgeschlossen, dass es zu Problemen kommt, weil plötzlich eine neuere Version einer Anwendung verwendet wird.

##Verwendung
Mit folgendem Kommando kannst Du einen Container von diesem Image starten:

`docker run --rm -it -v $(pwd)/build:/data inginform/devenv-sammler-windows`

Dabei ist wichtig, dass Du mit `-v` ein lokales (also vom Host) Verzeichnis in den Container hängst. Das Image definiert `/data` als volume. In dieses volume werden alle Anwendungen gelegt.

Alternativ könnte auch ein Data-Container verwendet werden. Das werde ich demnächst mal ausprobieren.
