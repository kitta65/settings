function gce
    if test -z "$gcp_project"; or test -z "$gce_zone"; or test -z "$gce_name"
        echo 'cannot find "$gcp_project", "$gce_zone" or "$gce_name"'
    else
        gcloud compute ssh --project $gcp_project --zone $gce_zone $gce_name
        # when login as a specific user, use `username@$gce_name`
    end
end
