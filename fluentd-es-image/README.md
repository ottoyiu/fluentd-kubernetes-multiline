# Docker Image for capturing Kubernetes/Docker logs using Fluentd and into ElasticSearch
This image is based off of:
https://github.com/kubernetes/kubernetes/tree/v1.6.2/cluster/addons/fluentd-elasticsearch/fluentd-es-image

## Collecting Docker Log Files with Fluentd and Elasticsearch
This directory contains the source files needed to make a Docker image
that collects Docker container log files using [Fluentd](http://www.fluentd.org/)
and sends them to an instance of [Elasticsearch](http://www.elasticsearch.org/).
This image is designed to be used as part of the [Kubernetes](https://github.com/kubernetes/kubernetes)
cluster bring up process.
