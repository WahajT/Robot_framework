"""Example custom keyword library.

Robot Framework turns every public method of this class into a keyword,
e.g. `reverse_string` becomes the keyword `Reverse String`.

Use from a suite with:  Library    CustomLibrary
"""

from robot.api.deco import keyword, library


@library(scope="GLOBAL", version="0.1.0")
class CustomLibrary:
    @keyword("Reverse String")
    def reverse_string(self, text: str) -> str:
        """Return ``text`` reversed."""
        return text[::-1]

    @keyword("Should Be Palindrome")
    def should_be_palindrome(self, text: str) -> None:
        """Fail unless ``text`` reads the same forwards and backwards."""
        normalized = "".join(ch.lower() for ch in text if ch.isalnum())
        if normalized != normalized[::-1]:
            raise AssertionError(f"'{text}' is not a palindrome")
