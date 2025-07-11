def search [search_term: string] {
  ls **/* | where { ($in.name | path basename) =~ $search_term }
}
