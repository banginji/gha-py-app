"""Unit tests for gha_py_app."""

import pytest

from gha_py_app import __version__, greet


def test_version():
    """Test that version is defined."""
    assert __version__ == "0.1.0"


def test_greet_default():
    """Test greet function with default parameter."""
    result = greet()
    assert result == "Hello, World!"


def test_greet_with_name():
    """Test greet function with custom name."""
    result = greet("Alice")
    assert result == "Hello, Alice!"


@pytest.mark.parametrize(
    "name,expected",
    [
        ("Bob", "Hello, Bob!"),
        ("Python", "Hello, Python!"),
        ("", "Hello, !"),
    ],
)
def test_greet_parametrized(name, expected):
    """Test greet function with various inputs."""
    assert greet(name) == expected
