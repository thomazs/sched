import numbers
from .exceptions import EValueMustBeNumber


def _get_processing_time(self):
    return self.__processing_time


def _set_processing_time(self, p):
    if p and not isinstance(p, numbers.Number):
        raise EValueMustBeNumber('Processing time must be a number')
    self.__processing_time = p


def _job_init(self, p=None):
    self.processing_time = p


class Job(type):

    def __new__(cls, clsname: str, bases, clsdict: dict):
        clsdict.update({
            '__processing_time': None, 
            'processing_time': property(_get_processing_time, _set_processing_time),
            '__init__': _job_init,
        })
        cls = super().__new__(cls, clsname, bases, clsdict)
        return cls
