#!/usr/bin/env bash

cd ../deploy/

export

openssl aes-256-cbc -K encrypted_${ENCRYPTION_LABEL}_key -iv encrypted_${ENCRYPTION_LABEL}_iv -in encrypted_${ENCRYPTION_LABEL}_key -out deploy_key -d

chmod 600 deploy_key
eval `ssh-agent -s`

ssh-add deploy_key

cd $TRAVIS_BUILD_DIR/..


rm -rf gh-pages

git clone -b gh-pages git@github.com:$TRAVIS_REPO_SLUG gh-pages

cd gh-pages

pwd

ls -la

mkdir -p downloads/eclipse/repository/

rm -rf downloads/eclipse/repository/*

mv ../mde_optimiser/src/releng/uk.ac.kcl.mdeoptimise.repository/target/* downloads/eclipse/repository/

git add --all

git config user.name "Travis CI"
git config user.email "alex+git-CIBUILD@onboot.org"

git commit -m "Published build id: $TRAVIS_BUILD_NUMBER"

git push origin gh-pages

echo "Done"
