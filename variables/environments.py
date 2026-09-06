"""Variable file: values available to suites that import it with

    Variables    environments.py

Override the target environment at run time:

    robot --variablefile variables/environments.py --variable ENV:staging tests/
"""

import os

ENV = os.environ.get("TEST_ENV", "dev")

_BASE_URLS = {
    "dev": "https://jsonplaceholder.typicode.com",
    "staging": "https://staging.example.com",
    "prod": "https://example.com",
}

BASE_URL = _BASE_URLS[ENV]
BROWSER = os.environ.get("BROWSER", "headlesschrome")
