#!/bin/bash
set -ex
sfctl application delete --application-id JavaActorApp1
sfctl application unprovision --application-type-name JavaActorApp1Type --application-type-version 1.0.0
sfctl store delete --content-path JavaActorApp1
