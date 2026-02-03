source .env

docker compose up -d --build --wait

URL="http://localhost:$PORT"

# Try xdg-open, then gnome-open, then a specific browser
if command -v xdg-open &> /dev/null; then
    # standard unix
    xdg-open "$URL" &
elif command -v gnome-open &> /dev/null; then
    # gnome
    gnome-open "$URL" &
elif command -v open &> /dev/null; then
    # macos
    open "$URL" &
elif command -v start &> /dev/null; then
    # windows
    start "$URL" &
elif command -v firefox &> /dev/null; then
    # firefox
    firefox "$URL" &
elif command -v google-chrome &> /dev/null; then
    # chrome
    google-chrome "$URL" &
else
    echo "Could not find a suitable web browser command."
    exit 1
fi