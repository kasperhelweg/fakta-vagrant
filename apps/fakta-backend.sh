#!/bin/bash
git clone git@github.com:liisberg-consulting/fakta-backend.git
cd fakta-backend
rvm --ruby-version use 1.9.3@fakta
git checkout -b staging origin/staging
