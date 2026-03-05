# Plan de Benchmarks

No basta con que funcione; debe ser eficiente.

## Métricas a medir:
- **TTFT (Time To First Token)**: Latencia inicial.
- **TPS (Tokens Per Second)**: Velocidad de generación sostenida.
- **VRAM/RAM Usage**: Memoria consumida (VRAM en GPU, RAM en CPU).

## Benchmarks en Entornos sin GPU:
Es vital medir la experiencia "Low-Cost":
- **Impacto de Cuantización**: Comparar Q4_K_M vs Q8_0 en CPU.
- **Consumo de Threads**: Evaluar cuántos hilos de CPU optimizan la velocidad antes de generar overhead.
- **Latencia de RAM**: Diferencia entre DDR4 y DDR5 para inferencia IA.

## Modelos a Evaluar:
- Llama 3.x (8B, 70B)
- Mistral v0.3
- Qwen 2.5 (especial para código)

## Metodología de Pruebas

Para garantizar la integridad de los resultados en esta fase temprana (Notebook Stage):

1. **Aislamiento Local**: Se cerrarán todas las aplicaciones no esenciales y se reiniciará el servicio de inferencia antes de cada prueba.
2. **Nodos de la Comunidad**: Invitamos a quienes tengan acceso a servidores Proxmox o hardware dedicado a ejecutar estos planes y compartir sus logs. **Buscamos donaciones de tiempo de cómputo para validar estos modelos en alta disponibilidad.**
3. **Versiones**: Se testearán cuantizaciones Q4, Q8 y FP16 para comparar pérdida de precisión vs velocidad.
