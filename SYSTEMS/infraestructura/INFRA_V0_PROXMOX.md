# Infraestructura v0 — Cluster Proxmox

Nuestro entorno de laboratorio corre sobre **Proxmox VE 8.x**.

## Especificaciones del Nodo 1 (Minimo):
- **CPU**: 8 Cores / 16 Threads (mínimo para orquestación).
- **RAM**: 64GB DDR4 (para cargar modelos medianos de 14B - 32B).
- **GPU**: NVIDIA RTX 3060 12GB o superior (con `PCIe Passthrough`).
- **Storage**: NVMe para acceso rápido a los pesos del modelo.

## Configuración Low-Cost (CPU-Only):
DSR Labs es inclusivo. Si no tienes GPU, el sistema **seguirá funcionando** gracias a que Ollama y vLLM soportan ejecución en CPU (usando AVX2/AVX512).

- **Requisito RAM**: Necesitarás al menos 16GB de RAM para modelos de 7B-8B, ya que el modelo se cargará enteramente en la memoria del sistema.
- **Limitación**: La velocidad (Tokens por segundo) será significativamente menor (1-3 t/s vs 40-60 t/s en GPU).
- **Optimización**: Recomendamos usar modelos cuantizados con `GGUF` para maximizar la velocidad en CPU.

## Configuración Especial:
- **LXC containers**: Para n8n, Redis y base de datos de logs.
- **VMs (Ubuntu Server)**: Dedicadas exclusivamente a Ollama / vLLM con GPU asignada.

Este diseño permite que los servicios de automatización no compitan por recursos con la inferencia pesada.
