# Descargador de subtítulos Subdivx para mpv

Este script Lua facilita la descarga de subtítulos desde subdivx.com para integrarlo con el reproductor multimedia mpv.

## Requisitos previos
* sistema operativo linux
* Reproductor [mpv](http://mpv.io)
* Python con [subdivx-dl](https://github.com/csq/subdivx-dl)


## Uso

Para utilizar este script, siga estos pasos:

1. Guarde el script Lua en su directorio de scripts mpv, por ejemplo:  
`/home/{user}/.config/mpv/scripts/subdivx-get.lua`.
2. Ejecute mpv con el script usando el siguiente comando:  
`mpv --script=/home/{usuario}/.config/mpv/scripts/subdivx-get.lua`

## Cómo funciona

1. El script comprueba si el subtítulo ya existe en el directorio.
2. Si el subtítulo no existe, busca subtítulos en subdivx.com.
3. Al localizar un subtítulo, se descarga y se incorpora al reproductor mpv.

## Atajos de Teclado

* Presiona la tecla `s` para obtener automáticamente los subtítulos.
* Presiona la tecla `c` para escanear archivos externos y cargar los subtítulos descargados.

---
**Notas:**
* Asegúrese de reemplazar `{user}` con su nombre de usuario real en las rutas de archivo.  
* Este script sólo ha sido probado en sistemas Linux.

## Otro idioma
[English](README.md)