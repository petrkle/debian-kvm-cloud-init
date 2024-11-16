#!/bin/bash

NAME=${NAME}

sudo virsh destroy ${NAME}

sudo virsh undefine --domain ${NAME}

sudo rm cidata.${NAME}.iso

rm ${NAME}.img
