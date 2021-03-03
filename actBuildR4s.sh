#!/usr/bin/env bash
#
# install act
# curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

#github_runner=ubuntu-latest
github_runner=ubuntu-20.04
#github_runner=ubuntu-18.04
#github_runner=ubuntu-16.04

#dockerImg=nektos/act-environments-ubuntu:18.04
dockerImg=catthehacker/ubuntu:runner-20.04

#act -v --privileged --platform ${github_runner}=${dockerImg}
act workflow_dispatch -W ./.github/workflows/build_Lede_R4S.yml -v -P ${github_runner}=${dockerImg}

#本地项目挂载进去编译
#act workflow_dispatch -W ./.github/workflows/build_Lede_R4S.yml -v -P ${github_runner}=${dockerImg} -b -C