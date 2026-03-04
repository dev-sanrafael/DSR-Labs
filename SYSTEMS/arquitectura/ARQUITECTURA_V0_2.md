# Arquitectura v0.2 — IA Local Distribuida

La versión 0.2 abandona el flujo lineal simple para prepararse para la escala.

## Cambios Clave:
1. **Asincronía**: Introducción de una cola (Redis) entre el orquestador y el modelo.
2. **Capa de Control**: Los prompts ahora pasan por un chequeo de seguridad local antes de ejecutarse.
3. **Múltiples Nodos**: Preparación para que el orquestador pueda elegir entre diferentes VMs de Proxmox según la carga.

## Diagrama Conceptual:
`Usuario -> API Gateway -> Queue (Redis) -> Worker (vLLM/Ollama) -> Logs (SQLite)`

Esto nos permite procesar peticiones sin bloquear el sistema mientras el modelo piensa.
