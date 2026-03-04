---
title: "Día 13: La soberanía empieza en el fierro"
date: 2026-01-25
tags: [infraestructura, proxmox, soberania]
---

# Día 13: La soberanía empieza en el fierro

Para construir IA real, necesitamos control total sobre el hardware. No basta con alquilar nubes de otros; necesitamos nuestro propio laboratorio.

### Por qué Proxmox?
Hemos decidido que el corazón de DSR Labs correrá sobre **Proxmox Virtual Environment**.

1. **Aislamiento**: Podemos tener contenedores (LXC) para servicios ligeros y VMs para modelos pesados.
2. **Passthrough de GPU**: Crucial para que nuestros modelos locales hablen directo con el hardware sin capas de abstracción lentas.
3. **Escalabilidad**: Proxmox nos permite crecer de un nodo a un cluster sin perder el control.

La infraestructura no se imagina. Se hace funcionar sobre fierros que podemos tocar y apagar.

![Proxmox Logo](https://www.proxmox.com/images/proxmox/proxmox-logo-color-stacked.png)
