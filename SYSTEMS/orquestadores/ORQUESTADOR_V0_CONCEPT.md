# Orquestador v0 — Concepto de Flujo

El orquestador de DSR Labs no es solo un puente; es un **director de orquesta**.

## Funciones Core:
- **Routing**: Envía la pregunta al modelo más apto (ej: Qwen para código, Llama para texto).
- **Sanitización**: Limpia el prompt para evitar inyecciones.
- **Audit Log**: Guarda cada paso de la decisión en una base de datos local.

## Evolución v0 -> v1:
Actualmente el orquestador es asíncrono pero manual. El objetivo para el día 60 es que sea **autónomo**, capaz de re-intentar llamadas fallidas y balancear carga entre nodos de Proxmox automáticamente.
