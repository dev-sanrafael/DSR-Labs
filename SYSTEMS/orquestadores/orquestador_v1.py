#!/usr/bin/env python3
"""
DSR Labs Orchestrator v1.0
Arquitectura: Síncrona Mejorada
Novedades: Soporte .env, logging robusto, validación de inputs.
"""

import os
import sys
import json
import logging
import requests
from dotenv import load_dotenv

# Cargar configuración desde .env
load_dotenv()

# Configuración desde entorno o valores por defecto
OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434/api/generate")
MODEL_NAME = os.getenv("MODEL_NAME", "qwen3:4b")
TIMEOUT = int(os.getenv("TIMEOUT", "300"))
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO").upper()
LOG_FILE = os.getenv("LOG_FILE", "orchestrator.log")

# Configurar Logging
logging.basicConfig(
    level=LOG_LEVEL,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger("DSR_Orchestrator")

def validate_input(text: str) -> bool:
    """
    Validación básica de seguridad y contenido.
    """
    if not text.strip():
        logger.error("Input vacío detectado.")
        return False
    if len(text) > 4000:
        logger.warning("Input demasiado largo, posible riesgo de DoS.")
        return False
    return True

def call_model(prompt: str) -> str:
    """
    Llama a Ollama y maneja excepciones.
    """
    logger.info(f"Enviando petición a modelo: {MODEL_NAME}")
    payload = {
        "model": MODEL_NAME,
        "prompt": prompt,
        "stream": False
    }

    try:
        response = requests.post(
            OLLAMA_URL,
            json=payload,
            timeout=TIMEOUT
        )
        response.raise_for_status()
        data = response.json()
        logger.debug("Respuesta recibida exitosamente.")
        return data.get("response", "").strip()
    
    except requests.exceptions.Timeout:
        logger.error("La petición excedió el tiempo límite (TIMEOUT).")
        raise
    except requests.exceptions.RequestException as e:
        logger.error(f"Error en la conexión con Ollama: {e}")
        raise

def main():
    logger.info("DSR Orchestrator v1.0 Iniciado.")
    
    # Leer input
    if len(sys.argv) > 1:
        user_input = " ".join(sys.argv[1:])
    else:
        logger.info("Esperando input desde STDIN...")
        user_input = sys.stdin.read()

    if not validate_input(user_input):
        sys.exit(1)

    try:
        resultado = call_model(user_input)
        print("\n--- RESPUESTA DSR LABS ---")
        print(resultado)
        print("--------------------------\n")
        logger.info("Proceso completado con éxito.")
    except Exception as e:
        logger.critical(f"Falla crítica en el flujo: {e}")
        sys.exit(2)

if __name__ == "__main__":
    main()
