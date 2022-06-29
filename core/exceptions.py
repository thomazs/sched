
class EValueMustBeNumber(Exception):
    def __init__(self, *args: object, message=None) -> None:
        if message is None:
            message = 'Value must be a number.'
        super().__init__(message, *args)
