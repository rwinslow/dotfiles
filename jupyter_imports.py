import copy
import pickle
import pprint
import random
from collections import defaultdict
from datetime import datetime
from datetime import timedelta
from itertools import groupby
from types import SimpleNamespace

import matplotlib as mpl
import matplotlib.dates as mdates
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from scipy import stats

from common.warehouse_managers import BQManager, GCSManager

# Plotting.
%matplotlib inline
plt.style.use('ggplot')

# Data managers.
bqm = BQManager()
pp = pprint.PrettyPrinter()

# Convenience.
infinite_defaultdict = lambda: defaultdict(infinite_defaultdict)
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)

