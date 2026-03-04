#!/usr/bin/env python3
"""
orquestador_v0
Arquitectura síncrona: una request → una respuesta
Orquesta llamadas a Ollama (localhost) desde CLI / scripts.
"""

import sys
import json
import requests

# Configuración básica
OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL_NAME = "qwen3:4b"
TIMEOUT = 300  # segundos


def build_prompt(user_input: str) -> str:
    """
    Construye el prompt final enviado al modelo.
    En v0 es un passthrough simple.
    """
    return user_input.strip()


def call_ollama(prompt: str) -> str:
    """
    Llama a la API de Ollama de forma síncrona.
    """
    payload = {
        "model": MODEL_NAME,
        "prompt": prompt,
        "stream": False
    }

    response = requests.post(
        OLLAMA_URL,
        json=payload,
        timeout=TIMEOUT
    )

    response.raise_for_status()

    data = response.json()
    return data.get("response", "").strip()


def main():
    """
    Punto de entrada del orquestador.
    Lee prompt desde:
    - argumento CLI
    - o stdin (pipe / heredoc)
    """
    if len(sys.argv) > 1:
        user_input = " ".join(sys.argv[1:])
    else:
        user_input = sys.stdin.read()

    if not user_input.strip():
        print("Error: prompt vacío", file=sys.stderr)
        sys.exit(1)

    prompt = build_prompt(user_input)

    try:
        output = call_ollama(prompt)
        print(output)
    except requests.RequestException as e:
        print(f"Error llamando a Ollama: {e}", file=sys.stderr)
        sys.exit(2)


if __name__ == "__main__":
    main()
