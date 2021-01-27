# DreamFactory Helm Chart

This project is an alpha, please proceed with caution using this in production.

## Quick Start

Customize your system by modifying the values.yaml file.

To start the instance you can run: `$ helm install dreamfactory . `

Then follow the notes that get printed out to setup port forwarding.

## Overriding Configuration Variables

Default DreamFactory behavior can be modified using environment variables managed in the root directory `.env` file. You can view a complete list of variables [in the guide](https://guide.dreamfactory.com/docs/appendix-a/). If you'd like to modify these variables using Helm, open the `Values.yaml` file and add the variables and their associated values to the `image` dictionary, like so:

    image:
      repository: dreamfactorysoftware/dreamfactory
      pullPolicy: Always
      tag: "4.3.1"
      env:
        APP_LOG_LEVEL: debug

