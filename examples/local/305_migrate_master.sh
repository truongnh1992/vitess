#!/bin/bash

# Copyright 2018 The Vitess Authors.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# this script migrates traffic for the master tablet

set -e

script_root=`dirname "${BASH_SOURCE}"`

./lvtctl.sh MigrateServedTypes customer/0 master

# data has been copied over to shards, and databases for the new shards are now available
mysql -h 127.0.0.1 -P 15306 -u mysql_user --table < $script_root/../common/select_customer-80_data.sql
mysql -h 127.0.0.1 -P 15306 -u mysql_user --table < $script_root/../common/select_customer80-_data.sql

disown -a
