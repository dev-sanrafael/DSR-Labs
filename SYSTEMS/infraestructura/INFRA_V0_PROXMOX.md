# Infraestructura v0 — Entorno de Desarrollo y Visión

DSR Labs nace como un laboratorio de recursos limitados pero ambición técnica alta. No esperamos a tener el hardware ideal para empezar a construir; construimos con lo que tenemos y diseñamos para lo que vendrá.

## Realidad Actual: Desarrollo en Notebook
Hoy, el núcleo de DSR Labs se ejecuta localmente en hardware personal.
- **Entorno**: Windows 11 / WSL2 / Linux (según disponibilidad del desarrollador).
- **Ejecución**: Modelos cuantizados (GGUF/EXL2) para maximizar el uso de RAM y iGPUs.

## Visión de Escala: Cluster Proxmox
Nuestra meta a largo plazo es migrar a un entorno controlado de **Proxmox VE 8.x**.

### Especificaciones del Nodo Ideal (Meta):
- **CPU**: 8 Cores / 16 Threads.
- **RAM**: 64GB DDR4.
- **GPU**: NVIDIA RTX 3060 12GB+ (con `PCIe Passthrough`).

## Nodos de la Comunidad (Colaboración)
Al no contar con un servidor dedicado propio, DSR Labs apuesta por una **infraestructura distribuida**.
> [!IMPORTANT]
> **Buscamos Colaboradores**: Si tienes hardware excedente o un servidor con Proxmox que quieras poner a disposición del proyecto para pruebas de orquestación, únete a nuestra comunidad. El avance de DSR Labs depende de la colaboración colectiva.

Este diseño permite que los servicios de automatización se desarrollen de forma agnóstica al hardware, listos para ser desplegados en cualquier nodo voluntario.
