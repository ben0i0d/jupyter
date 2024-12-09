#!/bin/bash
# 定义旧镜像名称的前缀和新的命名规则
OLD_PREFIX="eoelab.org:1027/eoeair"
NEW_PREFIX="ghcr.io/eoeair"
# 获取所有与旧前缀匹配的镜像，并进行重命名
docker images --format "{{.Repository}}:{{.Tag}}" | grep "$OLD_PREFIX" | while read OLD_IMAGE; do
 NEW_IMAGE=${OLD_IMAGE/$OLD_PREFIX/$NEW_PREFIX}
 echo "Renaming $OLD_IMAGE to $NEW_IMAGE"
 docker tag "$OLD_IMAGE" "$NEW_IMAGE"
done