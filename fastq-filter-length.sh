
#!/bin/bash


paste - - - - | awk -v min_len="$1" '(length($2) > min_len)' | tr "\t" "\n"

