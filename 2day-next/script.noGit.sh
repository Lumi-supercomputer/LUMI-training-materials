#! /opt/homebrew/bin/bash

sed \
    -e 's|00_Introduction|00-Introduction|g' -e 's|00_introduction|00-Introduction|g' -e 's|00-introduction|00-Introduction|g' \
    -e 's|01_architecture|01-Architecture|g' -e 's|01_Architecture|01-Architecture|g' -e 's|01-architecture|01-Architecture|g' \
    -e 's|02_CPE|02-CPE|g' \
    -e 's|03_LUMI_access|03-Access|g' -e 's|03_Getting_Access|03-Access|g' -e 's|03-access|03-Access|g' \
    -e 's|04_Modules_on_LUMI|04-Modules|g' -e 's|04_Modules|04-modules|g' -e 's|04-modules|04-Modules|g' \
    -e 's|05_Software_stacks|05-SoftwareStacks|g' -e 's|05-software|05-SoftwareStacks|g' \
    -e 's|06_Slurm|08-Slurm|g' -e 's|08_Slurm|08-Slurm|g' -e 's|08-slurm|08-Slurm|g' \
    -e 's|07_Binding|09-Binding|g' -e 's|09_Binding|09-Binding|g' -e 's|09-binding|09-Binding|g' \
    -e 's|10_Lustre|10-Lustre|g' -e 's|10-lustre|10-Lustre|g' \
    -e 's|11_Containers|11-Containers|g' -e 's|11-containers|11-Containers|g' \
    -e 's|12_Support|12-Support|g' -e 's|12-support|12-Support|g' \
    -e 's|13_What_else|13-WhatElse|g' \
    -e 's|E03_Exercises_1|E03-Exercises-1|g' -e 's|E04_Exercises_2|E04-Exercises-2|g' -e 's|E05_Exercises_3|E05-Exercises-3|g' \
    -e 's|E07_Exercises_4|E09-Exercises-4|g' -e 's|E09_Exercises_4|E09-Exercises-4|g' \
    -i '.orig2' $1
