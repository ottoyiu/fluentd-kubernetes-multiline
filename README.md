# fluentd-kubernetes-multiline
Kubernetes log aggregation using fluentd that supports multiline logging.

## Kubernetes Pod annotations
Specify these annotations at the pod level to adjust the behaviour of the log aggregator.

Annotation Key          | Description                                            | Example
----------------------- | ------------------------------------------------------ | ------------
multiline_log           | regexp of expected start of a log line                 | ```/^\d{4}-\d{1,2}-\d{1,2}/``` will match any lines that start with YYYY-MM-DD as a new line
log_drop                | if set, then drop logs for pod                         | ```true``` to drop logs
log_format              | regexp to format log line; used for indexing fields    | ```/^(?<date>\d{4}-\d{1,2}-\d{1,2})/``` to capture date as a field
