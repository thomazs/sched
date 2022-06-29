from simple.job import Job as SimpleJob
from core.exceptions import EValueMustBeNumber


def test_job_create_simple():
    j = SimpleJob()
    assert j is not None


def test_job_create_with_processing_time():
    j = SimpleJob(5)
    assert j is not None and j.processing_time == 5


def test_job_create_with_fail():
    try:
        j = SimpleJob('hello')
    except Exception as e:
        j = e
    assert isinstance(j, EValueMustBeNumber)
