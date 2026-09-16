function fish_prompt
    printf '%s@%s > ' $USER (hostname -s)
end