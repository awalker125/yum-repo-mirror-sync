# yum-repo-mirror-sync

This is a wrapper around the reposync command which can be used to mirror a public yum repository. This might be useful for:

* reduce bandwith across the internet.
* create a controlled snapshot in time of a changing repository.


By default the script makes the mirrors under /mirrors.

Edit the following line to change this:

	export MIRRORS_LOCATION=/mirrors
