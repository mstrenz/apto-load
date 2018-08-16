#!/usr/bin/env bash
bzt \
    -o scenarios.load.requests.0.url="${env}/checkLogin"\
    -o scenarios.load.requests.2.url="${env}/api/desktop/metadata/fieldcheck"\
    -o scenarios.load.requests.3.url="${env}/api/v3/call-list"\
    -o scenarios.load.requests.4.url="${env}/api/v3/companies"\
    -o scenarios.load.requests.5.url="${env}/api/v3/contacts"\
    -o scenarios.load.requests.6.url="${env}/api/v3/properties" \
    -o scenarios.load.requests.0.headers.Authorization="Bearer ${token}" \
    -o modules.console.disable=true \
    -o execution.0.concurrency=${users} \
    -o execution.0.hold-for=${length} site_test.yml