def search [search_term: string] {
  ls **/* | where { ($in.name | path basename) =~ $search_term }
}

def value [column_name: string] {
  get $column_name | get 0
}

$env.config.show_banner = false
