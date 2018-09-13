# -*- coding: utf-8 -*-

# Python2 vs Python3
try:
    from Queue import Queue
except ImportError:
    from queue import Queue

from ScoutSuite.providers.base.configs.base import BaseConfig


class AWSBaseConfig(BaseConfig):

    def _is_provider(self, provider_name):
        if provider_name == 'aws':
            return True
        else:
            return False