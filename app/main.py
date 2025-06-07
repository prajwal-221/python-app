# app/main.py
import os

def print_env_vars():
    print(" Decrypted Environment Variables:")
    for key, value in os.environ.items():
        if key.startswith("APP_"):
            print(f"{key} = {value}")

if __name__ == "__main__":
    print_env_vars()
