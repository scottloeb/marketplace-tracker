# generate_test_module.py
from modulegenerator_claude import generate_module

def main():
    # Generate the module
    module_path = generate_module(
        uri="bolt://localhost:7687",
        username="neo4j",
        password="your-password",  # Replace with your actual password
        graph="test"
    )
    
    print(f"Generated module at: {module_path}")

if __name__ == "__main__":
    main()