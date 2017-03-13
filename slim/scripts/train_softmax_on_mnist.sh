#!/bin/bash
#
# This script performs the following operations:
# 1. Downloads the MNIST dataset
# 2. Trains a Softmax model on the MNIST training set.
# 3. Evaluates the model on the MNIST testing set.
#
# Usage:
# cd slim
# ./slim/scripts/train_softmax_on_mnist.sh

# Where the checkpoint and logs will be saved to.
TRAIN_DIR=/tmp/softmax-model

# Where the dataset is saved to.
DATASET_DIR=/tmp/mnist

# Download the dataset
python download_and_convert_data.py \
  --dataset_name=mnist \
  --dataset_dir=${DATASET_DIR}

# Run training.
python train_image_classifier.py \
  --train_dir=${TRAIN_DIR} \
  --dataset_name=mnist \
  --dataset_split_name=train \
  --dataset_dir=${DATASET_DIR} \
  --model_name=softmax \
  --preprocessing_name=lenet \
  --max_number_of_steps=5000 \
  --batch_size=50 \
  --learning_rate=0.01 \
  --save_interval_secs=60 \
  --save_summaries_secs=60 \
  --log_every_n_steps=100 \
  --optimizer=sgd \
  --learning_rate_decay_type=fixed \
  --weight_decay=0

# Run evaluation.
python eval_image_classifier.py \
  --checkpoint_path=${TRAIN_DIR} \
  --eval_dir=${TRAIN_DIR} \
  --dataset_name=mnist \
  --dataset_split_name=test \
  --dataset_dir=${DATASET_DIR} \
  --model_name=softmax \
  --preprocessing_name=lenet
