from typing import Optional, Dict, Any

from app.common.exceptions.http import DevonHttpException


class InvalidImageFormatException(DevonHttpException):
    def __init__(self, detail: str = "Invalid image format", headers: Optional[Dict[str, Any]] = None):
        super().__init__(status_code=400, detail=detail, headers=headers)
