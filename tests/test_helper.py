import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
import helper  # noqa: E402


def test_add():
    assert helper.add(1, 2) == 3
