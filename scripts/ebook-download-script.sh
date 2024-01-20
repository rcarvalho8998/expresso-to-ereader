#!/bin/sh

source $HOME/.bash_profile

ebook-convert /recipes/expresso.recipe /import/expresso.epub --username $EXPRESSO_USERNAME --password $EXPRESSO_PASSWORD >> /var/log/cron.log 2>&1