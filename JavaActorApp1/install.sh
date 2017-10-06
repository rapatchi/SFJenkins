#!/bin/bash
set -ex
sfctl application upload --path JavaActorApp1 --show-progress
sfctl application provision --application-type-build-path JavaActorApp1
sfctl application create --app-name fabric:/JavaActorApp1 --app-type JavaActorApp1Type --app-version 1.0.0
