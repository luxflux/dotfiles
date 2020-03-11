function cluster
  gcloud config configurations activate $argv
  kubectx $argv
end
