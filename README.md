# OpenStack Client

A container of the OpenStack [OSC][openstack-docs-openstackclient] command-line client.

> OpenStackClient (aka OSC) is a command-line client for OpenStack that brings the command set for Compute, Identity, Image, Object Storage and Block Storage APIs together in a single shell with a uniform command structure.

## Usage

You can pull the container from Docker Hub or build it manually, see below.

```sh
docker pull darinegan/openstack-client
```

The container requires two parameters to be defined:

- `OPENRC_SH` defines the path of an OpenStack RC file which sets the required environment variables for the command-line client.
- `OS_CACERT` defines the path of the certificate for the associated OpenStack RC file above.

In order of precedence, these parameters can be defined as follows.

1. Environment Variable
2. Makefile.local

To run the container, issue the following command.

```sh
make run
```

## Building from Source

To build the container, issue the following commmand.

```sh
make
```

[openstack-docs-openstackclient]: http://docs.openstack.org/developer/python-openstackclient "OpenStack Documentation OpenStackClient"
