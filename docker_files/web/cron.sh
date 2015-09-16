#!/bin/bash

cd /code
whenever -w
exec cron -f
