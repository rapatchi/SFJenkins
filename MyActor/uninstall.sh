#!/bin/bash

azure servicefabric application delete fabric:/MyActor
azure servicefabric application type unregister MyActorType 1.0.0
