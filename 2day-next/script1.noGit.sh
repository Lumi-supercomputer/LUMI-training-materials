#! /opt/homebrew/bin/bash

sed \
    -e 's|08-Slurm|06-Slurm|g' \
    -e 's|09-Binding|07-Binding|g' \
    -e 's|10-Lustre|08-Lustre|g' \
    -e 's|11-Containers|09-Containers|g' \
    -e 's|12-Support|10-Support|g' \
    -e 's|E03-Exercises-1|E03-Access|g' \
    -e 's|E04-Exercises-2|E04-Modules|g' \
    -e 's|E05-Exercises-3|E05-SoftwareStacks|g' \
    -e 's|E07-Exercises-4|E07-Binding|g' \
    -e 's|extra-00-Introduction|MI01-IntroductionCourse|g' \
    -e 's|extra-06-WrapUpDay1|MI02-WrapUpDay1|g' \
    -e 's|extra-07-IntroductionDay2|MI03-IntroductionDay2|g' \
    -e 's|extra-13-WhatElse|MI04-WhatElse|g' \
    -i '.orig2' $1
