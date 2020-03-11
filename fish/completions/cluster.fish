function __fish_cluster_complete_profiles
  kubectx
end

complete -f -c cluster
complete -f -c cluster -n "not __fish_seen_subcommand_from (__fish_cluster_complete_profiles)" -a "(__fish_cluster_complete_profiles)"
