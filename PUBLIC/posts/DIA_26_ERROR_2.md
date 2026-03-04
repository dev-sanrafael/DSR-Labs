---
title: "Día 26: El Laberinto de las GPUs"
date: 2026-02-07
tags: [error, proxmox, gpu]
---

# Día 26: Error / Aprendizaje #2

Ayer el laboratorio quedó ciego. Al intentar escalar a una segunda VM, el passthrough de la GPU falló, bloqueando el host de Proxmox.

### La Causa
Conflictos entre los drivers del host y los de la VM. No habíamos deshabilitado correctamente los drivers open-source en el Proxmox.

### La Lección
En hardware real, la configuración del host es tan crítica como el código de la aplicación. 

### El Cambio
Hemos estandarizado un script de "Pre-vuelo" para cada nodo del cluster que valida el estado del PCIe antes de arrancar cualquier modelo.
