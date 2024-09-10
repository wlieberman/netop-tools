#!/bin/bash
#
# find all dev files
#
find install ops rdmatest restart uc uninstall upgrade usecase -name \*.sh > allsh
ls *.sh >> allsh
find install ops rdmatest restart uc uninstall upgrade usecase -name \*.cfg > allcfg
ls *.cfg >> allcfg
find install ops rdmatest restart uc uninstall upgrade usecase -name \*.yaml > allyaml
ls *.cfg >> allcfg
