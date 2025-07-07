#!/usr/bin/env bash
set -e

BASE="."

# DevOps (already exists but included for completeness)
mkdir -p "$BASE"/devops/{git,ci-cd,containerization,kubernetes,infrastructure-as-code,microservices}

# Deep Learning & Machine Learning
mkdir -p "$BASE"/deep-learning-ml/{tensorflow,torch,scikit-learn,data-preprocessing,feature-engineering,hyperparameter-tuning,model-deployment}

# LLMs
mkdir -p "$BASE"/llms/{prompt-engineering,fine-tuning,embeddings-retrieval,rag,inference-optimization,api-integrations}

# Mathematics
mkdir -p "$BASE"/mathematics/{linear-algebra,probability-statistics,multivariate-calculus,convex-optimization,information-theory}

# Research
mkdir -p "$BASE"/research/{experimental-design-ab-testing,literature-review,reproducible-workflows,technical-writing,peer-review}

echo "Directory structure initialized under '$BASE'"
