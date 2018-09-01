for file in ~/{.prompt,.load,.path,.source,.aliases,.functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
