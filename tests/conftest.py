# tests/conftest.py
import sys
import os

# Füge das Hauptverzeichnis zum sys.path hinzu, damit es für Importe verfügbar ist
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))