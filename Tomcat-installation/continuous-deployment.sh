#!/bin/bash
#prerequisite: 
##make sure you user connect scp to the remote host either by -i file or having public keys available in the remote server
# Config
TARGET_DIR="/home/ec2-user/maven-web-application/target"
REMOTE_USER="ec2-user"
REMOTE_HOST="172.31.12.12"
REMOTE_PATH="/home/ec2-user/tomcatinfo"
SSH_KEY="/path/to/private-key.pem"

# Start checking loop
while true; do
    WAR_FILE=$(find "$TARGET_DIR" -maxdepth 1 -type f -name "*.war" | head -n 1)

    if [ -f "$WAR_FILE" ]; then
        echo "$(date): Found WAR file - $WAR_FILE"

        # Attempt deployment using specified SSH key
        #if scp -i "$SSH_KEY" "$WAR_FILE" "$REMOTE_USER@$REMO/home/ec2-user/tomcatinfo
	if scp "$WAR_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"; then
            echo "Successfully deployed"
            exit 0
        else
            echo "$(date): Deployment failed. Retrying..."
        fi
    else
        echo "$(date): No WAR file found in $TARGET_DIR"
    fi

    # Wait 60 seconds before checking again
    #sleep 5
done
