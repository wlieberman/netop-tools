#!/usr/bin/env python
#
# from the nic-cluster-policy.yaml
# prune the "status" and unneeded "metadata" from the yaml doc
# to make it a policy that can be applied fro a debug env
#
import sys
import yaml

def main(argv):

    with open(argv[0]) as stream:
        try:
            #print(yaml.safe_load(stream))
            file_artifacts = yaml.safe_load(stream)
            pydict = dict(file_artifacts.items())
            #print(pydict)
            items = pydict['items']
            #print(items[0]['status'])
            del items[0]['status']
            del items[0]['metadata']['annotations']
            del items[0]['metadata']['creationTimestamp']
            del items[0]['metadata']['generation']
            del items[0]['metadata']['labels']
            del items[0]['metadata']['resourceVersion']
            del items[0]['metadata']['uid']
            pydict['items'] = items
            ymal_string=yaml.dump(pydict)
            #print("The YAML string is:")
            print(ymal_string)
            return 0
        except yaml.YAMLError as exc:
            print(exc)
            return 1

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
