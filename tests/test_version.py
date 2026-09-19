import subprocess  # nosec

from fastdfs_client import __version__


def _read_version() -> str:
    cmd = "fast version"
    r = subprocess.run(cmd.split(), capture_output=True, encoding="utf-8", check=False)  # nosec
    return r.stdout.strip().splitlines()[-1].strip().split()[-1]


def test_version() -> None:
    assert _read_version() == __version__
