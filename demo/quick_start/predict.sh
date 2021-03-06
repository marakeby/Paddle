#!/bin/bash
# Copyright (c) 2016 PaddlePaddle Authors. All Rights Reserved
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
set -e

cfg=trainer_config.lr.py
#cfg=trainer_config.emb.py
#cfg=trainer_config.cnn.py
#cfg=trainer_config.lstm.py
model="output/pass-00003"
paddle train \
    --config=$cfg \
    --use_gpu=false \
    --job=test \
    --init_model_path=$model \
    --config_args=is_predict=1 \
    --predict_output_dir=. \
2>&1 | tee 'predict.log'
paddle usage -l 'predict.log' -e $? -n "quick_start_predict_${cfg}" >/dev/null 2>&1

mv rank-00000 result.txt
