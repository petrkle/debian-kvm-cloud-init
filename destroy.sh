#!/bin/bash

NAME=debian12

sudo virsh destroy ${NAME}

sudo virsh undefine --domain ${NAME}

sudo rm cidata.iso

rm ${NAME}.img
