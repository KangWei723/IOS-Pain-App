#!/bin/bash
set -e
IFS='|'

AWSCLOUDFORMATIONCONFIG="{\
\"configLevel\":\"$AMPLIFY_CONFIG_LEVEL\",\
\"useProfile\":$AMPLIFY_USE_PROFILE,\
\"profileName\":\"$AMPLIFY_PROFILE_NAME\",\
\"accessKeyId\":\"$AMPLIFY_ACCESS_KEY_ID\",\
\"secretAccessKey\":\"$AMPLIFY_SECRET_ACCESS_KEY\",\
\"region\":\"$AMPLIFY_REGION\"\
}"
AMPLIFY="{\
\"projectName\":\"$AMPLIFY_PROJECT_NAME\",\
\"appId\": \"$AMPLIFY_APP_ID\",\
\"envName\":\"$AMPLIFY_ENV_NAME\",\
\"defaultEditor\":\"$AMPLIFY_DEFAULT_EDITOR\"\
}"
FRONTEND="{\
\"frontend\":\"$AMPLIFY_FRONTEND\"
}"
PROVIDERS="{\
\"awscloudformation\":$AWSCLOUDFORMATIONCONFIG\
}"

amplify pull \
--amplify $AMPLIFY \
--frontend $FRONTEND \
--providers $PROVIDERS \
--yes
