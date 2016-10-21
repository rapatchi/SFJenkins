#!/bin/bash

azure servicefabric application package copy MyActor fabric:ImageStore
azure servicefabric application type register MyActor
azure servicefabric application create fabric:/MyActor  MyActorType 1.0.0


