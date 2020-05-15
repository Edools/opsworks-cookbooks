name 'heimdall'
maintainer 'Heimdall team'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures heimdall'
long_description 'Installs/Configures heimdall'
version '0.1.0'
chef_version '12.18.31' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/heimdall/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/heimdall'

depends 'opsworks_ruby', '1.18.1'
# depends 'packages', '~> 1.0.0'