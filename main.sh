# @name        main.sh
# @description automatic all instance check and stop instance
# @version     0.1.0
# @date        2016/01/07
# @auther      aipa
#
#!/bin/bash
#################################################

# リージョン
REGION="ap-northeast-1"

# シェルで全インスタンスidを配列で取得
ALL_INSTANCE_ID=(`aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'`)

# 起動しているか確認
for INSTANCE_ID in "${ALL_INSTANCE_ID[@]}"
do
  INSTANCE_STATUS=`aws ec2 describe-instances --instance-ids=${INSTANCE_ID} | jq -r '.Reservations[].Instances[].State.Name'`
  # 起動していたら停止する
  if [ "${INSTANCE_STATUS}" == "running" ]; then
    echo ${INSTANCE_ID}
    # aws ec2 stop-instances --region=${REGION} --instance-ids=${INSTANCE_ID}
  fi
done