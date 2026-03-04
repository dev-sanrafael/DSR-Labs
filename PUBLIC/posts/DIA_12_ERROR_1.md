---
title: "Día 12: El primer error real"
date: 2026-01-24
tags: [aprendizaje, errores, logs]
---

# Día 12: El primer error real

En DSR Labs no escondemos los fallos. El proceso es parte del producto.

### El error
Al intentar ejecutar el `orquestador_v0` en un entorno con restricciones de memoria, la llamada a Ollama falló silenciosamente. No había timeout configurado adecuadamente y el proceso quedó colgado.

### El aprendizaje
La infraestructura local es traicionera si no se monitorea. No se puede asumir que el modelo siempre responderá en tiempo real bajo carga.

### La acción
Hemos implementado un `TIMEOUT` global en el script del orquestador y logs más verbosos para detectar dónde se rompe la cadena.

**DSR Labs no se detiene por el error, se fortalece con él.**
