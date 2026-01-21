---
title: Stack v0
permalink: /SYSTEMS/arquitectura/STACK_V0
---
Stack v0 de DSR Labs

Este documento define el **Stack v0** de DSR Labs.
No describe un sistema productivo ni infraestructura real.
Define **arquitectura lógica, flujos y decisiones iniciales** sobre las que luego se construirá código e infraestructura.

El Stack v0 se construye **a partir del trabajo conceptual inicial de Ignacio Exequiel Sanchez Saavedra**, primer colaborador del laboratorio, quien definió la base de arquitectura modular, el alcance v0 y la separación de capas del sistema.

Este día consolida ese material, lo ordena y lo lleva a un nivel decisional mínimo para poder avanzar sin rehacer todo más adelante.

---

## 🧪 AI Labs Platform – v0

Plataforma experimental para diseñar, ejecutar y evaluar *labs de IA* de forma modular, versionada y desacoplada de infraestructura y proveedores.

El foco del Stack v0 es:

* iterar rápido
* romper temprano
* tomar decisiones explícitas
* evitar deuda estructural temprana

---

## 🎯 Objetivo del Stack v0

* Probar ideas de IA de forma controlada
* Versionar experimentos (prompts, flujos, modelos)
* Desacoplar labs de modelos e infraestructura
* Construir una base clara para v1 y v2

---

## 🚧 Alcance del Stack v0

### Incluido

* Arquitectura lógica
* Ejecución síncrona
* Un único punto de entrada
* Orquestación de flujos de IA
* Manejo básico de errores
* Logging simple de ejecuciones

### Fuera de alcance (a propósito)

* Infraestructura
* Deploy
* Escalado
* Optimización
* Seguridad avanzada
* Costos y performance

Todo lo que está fuera de alcance **no está descartado**, solo **no se decide en v0**.

---

# FASE 1 — Arquitectura Declarativa

Qué es el sistema
Qué partes tiene
Qué no es

---

## 🧱 Capas del sistema

### API / Backend

Punto único de entrada al sistema.

**Responsabilidades:**

* recibir requests
* validar formato básico
* disparar la ejecución de un lab

**No hace:**

* lógica de negocio de IA
* decisiones de modelo
* orquestación de pasos

---

### Orquestador IA

Núcleo del sistema.

**Responsabilidades:**

* ejecutar el flujo definido por un lab
* coordinar pasos secuenciales
* invocar modelos y tools
* manejar errores de ejecución

**No hace:**

* validación de requests
* persistencia avanzada
* manejo de infraestructura

---

### Labs

Definición de un experimento de IA.

**Responsabilidades:**

* definir el flujo de ejecución
* declarar qué modelos y tools se usan
* versionar ideas y cambios

Un lab **no es** infraestructura.
Un lab **no es** deploy.
Un lab **no es** un endpoint.

---

### Model Adapters

Capa de abstracción de modelos.

**Responsabilidades:**

* encapsular la interacción con modelos
* evitar acoplamiento a un proveedor
* permitir cambios de modelo sin romper labs

---

### Tools

Funciones auxiliares opcionales.

Ejemplos:

* RAG
* búsquedas
* cálculos
* llamadas a APIs externas

Las tools **no controlan el flujo**, solo ejecutan tareas puntuales.

---

### Logging & Métricas

Registro mínimo de ejecución.

**Incluye:**

* inicio y fin de ejecución
* errores
* resultados básicos

**No incluye:**

* observabilidad avanzada
* dashboards
* alertas

---

# FASE 2 — Arquitectura Decisional (v0)

Qué hace cada cosa
Qué límites tiene
Qué se rompe si cambia

---

## Decisiones explícitas del Stack v0

### 1. Ejecución síncrona

Todas las ejecuciones son síncronas.
No hay colas.
No hay workers.
No hay paralelismo.

Si esto cambia en v1, **cambia el orquestador**, no los labs.

---

### 2. Un solo punto de entrada

Existe un único entrypoint al sistema.

Esto simplifica:

* control
* debugging
* evolución temprana

---

### 3. Orquestador imperativo

El orquestador ejecuta pasos de forma explícita.

No hay:

* DAG dinámico
* motor declarativo complejo
* planificación automática

Se elige por simplicidad y control en v0.

---

### 4. Labs como definición lógica

Un lab define:

* qué pasos se ejecutan
* en qué orden
* con qué dependencias

Un lab **no decide**:

* infraestructura
* costos
* escalado

---

### 5. Estado efímero

El estado de una ejecución vive **solo durante la ejecución**.

No se persiste estado entre corridas.
No hay memoria de largo plazo en v0.

---

### 6. Errores simples y visibles

Si algo falla:

* se corta la ejecución
* se registra el error
* se devuelve una respuesta clara

No hay retries automáticos.
No hay compensaciones.
No hay tolerancia a fallos compleja.

---

## Qué se rompe si cambiamos estas decisiones

* Cambiar síncrono → asíncrono rompe el orquestador
* Agregar múltiples entrypoints rompe la API
* Persistir estado rompe el modelo mental de v0
* Meter infraestructura ahora rompe la velocidad de iteración

Estas rupturas **son aceptables**, porque están contenidas por el Stack v0.

---

## Resultado del Día 6

Al finalizar el Día 6, DSR Labs tiene:

* un Stack v0 definido
* arquitectura clara
* decisiones explícitas
* límites conscientes
* una base real para escribir código

Nada de esto es definitivo.
Todo esto es **suficientemente claro para avanzar**.

---

## Próximo paso (fuera del Día 6)

A partir de este Stack v0:

* bajar un primer `orchestrator_v0`
* implementar el flujo mínimo
* validar que el diseño se puede ejecutar

Esto corresponde al **Día 7–8**.
