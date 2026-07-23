const TRASH_DIR: path = "~/.local/share/Trash"

# paths are the paths to the files you wish to remove
def main [...paths: path --empty-trash] {
  if $empty_trash {
    rm --recursive ~/.local/share/Trash/*
    return
  }

  for $path in $paths {
    let normal = $path | path expand
    if $normal == / {
      error make {
        msg: "you cannot rm /"
        label: {
          text: path
          span: (metadata $path).span
        }
      }
    }

    let trashed = $TRASH_DIR
      | path expand
      | path join ($normal | str substring 1..)

    try {
      mkdir ($trashed | path dirname)
      mv $path $trashed
    } catch {|err|
      print --stderr $err.msg
    }
  }
}
