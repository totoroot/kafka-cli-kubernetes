# Kafka-CLI on Kubernetes

[![Docker Pulls](https://img.shields.io/docker/pulls/totoroot/kafka-cli.svg)](https://hub.docker.com/r/totoroot/kafka-cli/)
[![Docker Stars](https://img.shields.io/docker/stars/totoroot/kafka-cli.svg)](https://hub.docker.com/r/totoroot/kafka-cli/)

This setup creates a simple container based on an [Alpine Linux](https://www.alpinelinux.org/) image with [glibc](https://www.gnu.org/software/libc/) and [Oracle JDK](https://www.oracle.com/java/technologies/javase-downloads.html#JDK11) to run all binaries provided by the [latest version](https://kafka.apache.org/downloads) of [Apache Kafka](https://kafka.apache.org/documentation/) in [Kubernetes](https://kubernetes.io/).

The base image can be found [here](https://hub.docker.com/r/ringcentral/jdk).

The automatically built images based on this repo's releases, which are pulled by the K8s pod can be found [here](https://hub.docker.com/r/totoroot/kafka-cli/).

Repositories similar to this one are [taion/kafka-cli](https://github.com/taion809/kafka-cli) and [conitas/kafka-cli](https://github.com/conitas/kafka-cli) which use different base images.

## Run the pod on Kubernetes:

_This is assuming that a Kafka cluster is already running in Kubernetes and the bootstrap server is reachable for the pod._

Modify the following environment variables according to your K8s cluster setup.

```
export KAFKA_NAMESPACE=kafka KAFKA_BOOTSTRAP_SERVER=kafka-bootstrap:9092 KAFKA_TOPIC=example
```

If the namespace does not yet exist, make sure to create it first:

```
kubectl create ns ${KAFKA_NAMESPACE}
```

Create the kafka-cli pod:

```
 kubectl -n ${KAFKA_NAMESPACE} apply -f kafka-cli-pod.yml
```                  

Create an example topic:

```                                   
 kubectl -n ${KAFKA_NAMESPACE} exec -it kafka-cli --  kafka-topics.sh --create --bootstrap-server ${KAFKA_BOOTSTRAP_SERVER} --topic ${KAFKA_TOPIC} --replication-factor 1 --partitions 1
```

Then run consumer on this newly created topic: 
```
 kubectl -n ${KAFKA_NAMESPACE} exec -it kafka-cli -- kafka-console-consumer.sh --bootstrap-server ${KAFKA_BOOTSTRAP_SERVER} --topic ${KAFKA_TOPIC} --from-beginning
```

Produce some messages on this topic:
```         
 kubectl -n ${KAFKA_NAMESPACE} exec -it kafka-cli --  kafka-console-producer.sh --broker-list ${KAFKA_BOOTSTRAP_SERVER} --topic ${KAFKA_TOPIC}
```


## Available commands:

All available commands for the latest release are listed below:

- connect-distributed.sh
- connect-mirror-maker.sh
- connect-standalone.sh
- kafka-acls.sh
- kafka-broker-api-versions.sh
- kafka-cluster.sh
- kafka-configs.sh
- kafka-console-consumer.sh
- kafka-console-producer.sh
- kafka-consumer-groups.sh
- kafka-consumer-perf-test.sh
- kafka-delegation-tokens.sh
- kafka-delete-records.sh
- kafka-dump-log.sh
- kafka-features.sh
- kafka-leader-election.sh
- kafka-log-dirs.sh
- kafka-metadata-shell.sh
- kafka-mirror-maker.sh
- kafka-preferred-replica-election.sh
- kafka-producer-perf-test.sh
- kafka-reassign-partitions.sh
- kafka-replica-verification.sh
- kafka-run-class.sh
- kafka-server-start.sh
- kafka-server-stop.sh
- kafka-storage.sh
- kafka-streams-application-reset.sh
- kafka-topics.sh
- kafka-verifiable-consumer.sh
- kafka-verifiable-producer.sh
- trogdor.sh
- zookeeper-security-migration.sh
- zookeeper-server-start.sh
- zookeeper-server-stop.sh
- zookeeper-shell.sh
