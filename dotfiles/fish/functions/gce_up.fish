function gce_up
    which gcloud
    if test $status -eq 1
        echo 'installation error `gcloud`'
    else if test -z "$gcp_project"; or test -z "$gce_zone"; or test -z "$gce_name"; or test -z "$gce_sync_dir"
        echo 'cannot find "$gcp_project", "$gce_zone", "$gce_name" or "$gce_sync_dir"'
    else
        gcloud compute scp --recurse --project $gcp_project --zone $gce_zone $gce_sync_dir/sync $gce_name:~/
    end
end
