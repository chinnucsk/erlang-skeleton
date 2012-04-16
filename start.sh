#!/bin/sh

APP=skeleton
COOKIE=skeleton

cd `dirname $0`
exec erl \
  -smp auto +K true +A 4 \
  -pa $PWD/ebin $PWD/deps/*/ebin \
  -config etc/app \
  -sname $APP -setcookie $COOKIE \
  -boot start_sasl \
  -s $APP $@
