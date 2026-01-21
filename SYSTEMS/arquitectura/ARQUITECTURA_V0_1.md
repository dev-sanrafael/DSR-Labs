# Arquitectura v0.1 — Cómo funciona DSR Labs hoy

DSR Labs no nace como un producto terminado.  
Nace como un laboratorio abierto.

Por eso, en esta primera versión de la arquitectura, priorizamos una sola cosa:  
**entender exactamente qué está pasando en el sistema**.

## Principio base

Hoy el funcionamiento es intencionalmente simple:

- Una persona envía un prompt desde su propia máquina  
- Ese prompt pasa por una capa mínima de control  
- Se ejecuta un modelo de lenguaje local  
- Se devuelve una respuesta  

Una request.  
Una respuesta.

## Diagrama v0.1

El flujo completo del sistema puede verse en el siguiente diagrama:

👉 **Diagrama Arquitectura v0.1**  
[`Diagrama de Arquitectura v0.1`](https://drive.google.com/file/d/1_-eIzoDZIRjKciZo7-duoCQqwQa4NOFz/view?usp=sharing)

Este diagrama representa el estado real del sistema hoy, no una proyección futura.

## Qué NO hay en v0.1

- No hay frontend  
- No hay nube  
- No hay servicios externos  

Todo corre en local.  
Todo se puede observar, repetir y auditar.

## Decisión consciente

Esto no es una limitación.  
Es una decisión consciente.

Antes de escalar, abstraer u optimizar, necesitamos una base:

- Comprensible  
- Observable  
- Real  

La arquitectura v0.1 no promete velocidad ni escala.  
Promete algo más importante: **realidad**.

## Punto de partida

Desde esta arquitectura mínima se construye todo lo demás:

- Orquestación  
- Infraestructura  
- Backend  
- Producto  
- Comunidad  

Nada se diseña en el aire.  
Todo parte de un sistema que ya existe y funciona.
