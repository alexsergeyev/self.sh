Selfie tool :)
Captures 2 seconds video from camera on OSX. Compress and upload optimized GIF to uploadcare CDN

### Install

```bash
brew install ffmpeg gifsicle
```

### Upload

Create free account on http://uploadcare.com and copy public key

UPLOADCARE_PUBLIC=XXXXXX ./self.sh

### Git hook

* Create new file .git/hooks/commit-msg
* chmod +x .git/hooks/commit-msg


```bash
DESCRIPTION=$(UPLOADCARE_PUBLIC=xxxxxx ./self.sh)

if [ -n "$DESCRIPTION" ]
then
   echo "" >> "$1"
   echo "![GIF]($DESCRIPTION)" >> "$1"
fi
```
