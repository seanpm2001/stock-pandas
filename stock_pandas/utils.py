def period_to_int(period: str):
    try:
        period = int(period)
    except ValueError:
        raise ValueError(
            'period must be a positive int, but got `{}`'.format(period)
        )

    if period <= 0:
        raise IndexError('period must be greater than 0')

    return period

COLUMNS = [
    'open',
    'high',
    'low',
    'close'
]

def is_ohlc_column(column: str):
    return column in COLUMNS


def
