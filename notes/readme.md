```

              __        
   ___  ___  / /____ ___
  / _ \/ _ \/ __/ -_|_-<
 /_//_/\___/\__/\__/___/.sh
 a script for managing markdown notes

```

#### features

*tag-based browsing:* tags may be defined inline, or in frontmatter

```markdown
---
tags: tag, note, example
---

Three tags have been defined in the frontmatter, here is another: #another
```

these tags may then be searched through the script, displaying all notes tagged with a given word

#### dependencies

`rofi`, `rg`, `fd`

#### configuration & usage

```sh
git clone https://github.com/mellowcoffee/scripts ~/scripts
```

```hyprlang
bind = SUPER, N, exec, ~/scripts/notes/notes.sh
```

you may configure the script by modifying the variables at the top:

```bash
terminal="foot"
editor="nvim"
folder="${HOME}/notes"
menu="rofi -dmenu -i -matching fuzzy -sort -sorting-method fzf -p"
```

the menu command must end with `-p` as it is the flag used by the script to set the prompt of the menu windows.
