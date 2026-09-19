from .client import AsyncDfsClient, FastdfsClient

__version__ = "1.3.0"
VERSION = tuple(map(int, __version__.split(".")))  # NOQA:RUF048


__all__ = (
    "VERSION",
    "AsyncDfsClient",
    "FastdfsClient",
)
