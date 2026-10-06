# # From https://github.com/leonidk/new_website
# mkdir -p tn/publications/images
# mogrify -path tn/publications/images -thumbnail 160x160 publications/images/*.png
# mogrify -path tn/publications/images -thumbnail 160x160 publications/images/*.jpg
# mogrify -path tn/publications/images -thumbnail 160x160 publications/images/*.gif

mkdir -p tn/publications/images

mogrify -path tn/publications/images \
  -filter Lanczos -resize "320x320>" \
  publications/images/*.png

mogrify -path tn/publications/images \
  -filter Lanczos -resize "320x320>" \
  publications/images/*.jpg

mogrify -path tn/publications/images \
  -filter Lanczos -resize "320x320>" \
  publications/images/*.gif