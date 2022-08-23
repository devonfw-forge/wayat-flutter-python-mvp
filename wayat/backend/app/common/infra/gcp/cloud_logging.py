import json
import logging
from datetime import datetime


class CloudRunJSONFormatter(logging.Formatter):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def format(self, record: logging.LogRecord) -> str:
        # Use default Formatter for exceptions
        if any([record.exc_info, record.stack_info, record.exc_text]):
            return super().format(record)

        log = {
            "message": super().format(record),
            # A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and up to nine fractional digits
            # Examples: "2014-10-02T15:01:23Z" and "2014-10-02T15:01:23.045123456Z"
            # https://cloud.google.com/logging/docs/reference/v2/rest/v2/LogEntry
            "timestamp": datetime.fromtimestamp(record.created).isoformat() + "Z",
            "severity": record.levelname,
            "labels": {
                "logger_name": record.name
            }
        }

        return json.dumps(log)
