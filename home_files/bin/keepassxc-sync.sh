cp ~/gdrive-shared/Passwords.kdbx ~/Downloads/Passwords.kdbx.old

echo "Pulling remote database..."
rclone sync "gdrive:shared/" ~/gdrive-shared
if [ $? -eq 0 ]; then
    echo "success."
else
    rclone config reconnect gdrive:
    exit 1
fi

echo "Merging local and remote..."
keepassxc-cli merge -s ~/Downloads/Passwords.kdbx.old ~/gdrive-shared/Passwords.kdbx
mv ~/Downloads/Passwords.kdbx.old ~/gdrive-shared/Passwords.kdbx

echo "Pushing merged database..."
rclone sync ~/gdrive-shared "gdrive:shared/"
if [ $? -eq 0 ]; then
    echo "success."
else
    rclone config reconnect gdrive:
    exit 1
fi
