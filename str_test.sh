#!/usr/bin/env bash

str="abc_"
z="[^0-9A-Za-z_]"

res=`echo "$str" | grep $z`
echo $res



res=`echo "$str" | grep '[^0-9A-Za-z_]'`
echo $res


s="one space"
r=`echo "$s" | grep '[[:space:]]'`
echo $r