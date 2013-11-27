#!/bin/bash
git clone git@github.com:liisberg-consulting/fakta-backend.git
cp ./apps/database.yml ./fakta-backend/config
cd fakta-backend
echo 1.9.3 > .ruby-version
echo fakta > .ruby-gemset
git checkout -b staging origin/staging
