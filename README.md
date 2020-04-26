## Creating stacks: ./create.sh <stackName> <configuration yml file> <parameters json file>
e.g. (vpc): ./create.sh capstone-stack-vpc network/network.yml network/network-parameters.json
e.g. (eks): ./create.sh capstone-stack-eks eks/eks.yml eks/eks-parameters.json

## Updating stacks: ./update.sh <stackName> <configuration yml file> <parameters json file>
e.g. (vpc): ./update.sh capstone-stack-vpc network/network.yml network/network-parameters.json
e.g. (eks): ./update.sh capstone-stack-eks eks/eks.yml eks/eks-parameters.json

Please, create network first, then eks.