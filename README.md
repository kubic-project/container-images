# containers-images

Source files required used to build the Kubic containers.

# Repository Layout

The source code of each image is organized as an independent KIWI project
in a dedicated folder under the root of the repository.

# Tagging images

The tag of the image is expected to be the same value as the main application
that the image is providing. In order to keep the application version and
image tag consistent over time there is an automation procedure in place for
the builds within the Open Build Service. The `replace_using_package_version`
service serves that purpose and should be used in the following way:

1. Include a placeholder in the kiwi description file as the tag value.
2. In OBS set the `replace_using_package_version` service to replace the
placeholder. 

Consider the following example for a mariadb image:

1. In `kubic-mariadb-image.kiwi` use the `%%TAG%%` placeholder:

```xml
(...)
<containerconfig name="kubic/mariadb" tag="%%TAG%%"/>
(...)
```

2. In the `_service` file of the OBS project include:

```xml
<service name="replace_using_package_version" mode="buildtime">
    <param name="file">kubic-mariadb-image.kiwi</param>
    <param name="regex">%%TAG%%</param>
    <param name="package">mariadb</param>
</service>
    
```

This configuration will set the tag to the mariadb package version at build
time. This specially handy for images based on rolling releases like
Tumbleweed, where the application versions might change at anytime.
