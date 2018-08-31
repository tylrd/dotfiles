for file in ~/{.load,.path,.source,.prompt,.aliases,.functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
