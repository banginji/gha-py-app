"""GitHub Actions Python Application.

A simple demonstration of the make-python-devex pattern with GitHub Actions CI.
"""

from loguru import logger

__version__ = "0.1.0"


def greet(name: str = "World") -> str:
    """Return a greeting message.

    Args:
        name: The name to greet. Defaults to "World".

    Returns:
        A greeting message string.
    """
    return f"Hello, {name}!"


def main() -> None:
    """Main entry point for the application."""
    logger.info("Starting gha-py-app")
    message = greet()
    logger.info(message)
    print(message)


if __name__ == "__main__":
    main()
