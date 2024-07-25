set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# List all available recipes.
list:
    @{{just_executable()}} --list --justfile "{{justfile()}}"

# Show the help for just itself
help:
    @{{just_executable()}} --help

# Serve the site locally.
serve:
    bundle exec jekyll serve --watch --drafts --livereload --host 0.0.0.0 --force_polling --unpublished --future