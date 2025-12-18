def decrement(x):
    return x - 1


def increment(x):
    return x + 1


def test_decrement_fail():
    assert decrement(3) == 4


def test_decrement_sucess():
    assert decrement(3) == 2


def test_increment_success():
    assert increment(3) == 4


def test_increment_fail():
    assert increment(3) == 2
