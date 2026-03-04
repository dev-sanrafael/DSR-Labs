# Orchestrators

Este directorio contiene la capa de **orquestación de sistemas de inteligencia artificial** del lab.

Aquí diseño y construyo cómo se ejecutan modelos, datos e infraestructura para producir resultados **controlados, observables y reproducibles**.

> **La IA no se “consume”. Se orquesta.**

---

## Rol dentro del lab

En sistemas de IA, el problema no es llamar a un modelo. El problema es **coordinar ejecución, estado, contexto, memoria y fallas**.

La orquestación define:
* **Qué modelo** se ejecuta.
* **En qué momento** ocurre la ejecución.
* **Con qué contexto** y memoria.
* **Qué ocurre si falla** (gestión de errores).
* **Qué queda persistido** (trazabilidad).

Sin esta capa hay prompts; no hay sistemas.

---

## Qué hay acá

En `orchestrators/` construyo:

* **Workflows de IA** con estado explícito.
* **Pipelines** de inferencia y decisión.
* **Coordinación** entre múltiples modelos.
* **Flujos largos** y reanudables.
* **Runtime** de ejecución y políticas de error, fallback y costo.

Todo está pensado para **ejecución real**, no para demos.

---

## Conceptos Base

### 1. Workflow
Una ejecución completa del sistema. No conoce la infraestructura, solo define flujo y reglas.
* Input versionado y contexto controlado.
* Estado persistente y secuencia de pasos.
* Política de error y output validado.

### 2. Step
Unidad mínima de ejecución.
* Hace una sola cosa y es **idempotente**.
* Puede fallar, pero no decide el flujo.
* Los steps ejecutan; el workflow decide.

---

## Gestión de Estado y Fallas

### Estado y Memoria
El estado es **explícito y persistente**. Nada vive solo en la RAM. Todo flujo puede reanudarse, repetirse y auditarse, incluyendo el contexto de entrada y las decisiones intermedias.

### Fallas y Costo
La falla no es un bug, es una condición esperada. Implementamos:
* **Retries** con políticas claras y **Timeouts** explícitos.
* **Fallback** entre modelos para asegurar disponibilidad.
* **Degradación funcional** y control estricto de costo por ejecución.

---

## Observabilidad
Si no puedo explicar qué hizo la IA paso a paso, el flujo está mal diseñado.
* **Logs estructurados** e identificadores únicos por ejecución.
* **Trazas por step** y métricas de tiempo/error/costo.
* **Outputs auditables**.

---

## Ejemplo de Workflow de IA Real

Caso: Procesar un documento enviado por un usuario, analizarlo con IA y devolver un resultado validado.



### Flujo Lógico
1.  **START**
2.  **Validar input**: Verifica formato. Si falla, aborta.
3.  **Inicializar estado**: Crea el ID de ejecución.
4.  **Extraer texto**: Conversión a texto plano (idempotente).
5.  **Preparar contexto**: Aplicación de reglas y prompts versionados.
6.  **Inferencia IA**: Ejecución con control de tokens y fallbacks.
7.  **Validar output**: Verificación de estructura y umbral de confianza.
8.  **Persistir resultado**: Guardado de estado final y métricas.
9.  **END**

### Ejemplo de Estado (JSON)

**Estado Inicial:**
```json
{
  "execution_id": "wf-2026-0001",
  "input": {
    "document_id": "doc_9821",
    "source": "user_upload"
  },
  "context": {},
  "memory": {},
  "status": "initialized"
}
```

**Estado Final:***

```json
{
  "execution_id": "wf-2026-0001",
  "status": "completed",
  "result": {
    "approved": true,
    "confidence": 0.92,
    "model_used": "model-primary-v3"
  }
}

```
