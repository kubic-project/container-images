# containers-images

Source files required used to build the Kubic containers.

## Repository Layout

The source code of each image is organized as an independent KIWI project
in a dedicated folder under the root of the repository.

Each folder contains a `*kiwi.ini` description file that is used as a template
to generate the Kubic & CaaSP description files by running the
`pre_checking.sh` script. This script will set the prefix for the image
name and the base image to use.

## Tagging images

The tag of the image is expected to be the same value as the main application
that the image is providing. In order to keep the application version and
image tag consistent over time there is an automation procedure in place for
the builds within the Open Build Service. The `replace_using_package_version`
service serves that purpose and should be used in the following way:

1. Include an arbitrary placeholder in the kiwi description file as the
tag value.
2. In OBS set the `replace_using_package_version` service to replace the
placeholder. 

Consider the following example for a mariadb image:

1. In `kubic-mariadb-image.kiwi` use the `%%VERSION%%` placeholder:

```xml
(...)
<containerconfig name="kubic/mariadb" tag="%%VERSION%%"/>
(...)
```

2. In the `_service` file of the OBS project include:

```xml
<service name="replace_using_package_version" mode="buildtime">
    <param name="file">kubic-mariadb-image.kiwi</param>
    <param name="regex">%%VERSION%%</param>
    <param name="parse-version">minor</param>
    <param name="package">mariadb</param>
</service>
```

This configuration will set the tag to the mariadb package version at build
time. This specially handy for images based on rolling releases like
Tumbleweed, where the application versions might change at anytime.

The `parse-version` optional parameter is used to simplify the version string.
It can take `major`, `minor` and `patch` values. `patch` will use a version
style like `MAJOR.MINOR.PATCH` (three decimal numbers separated by dots),
`minor` something like `MAJOR.MINOR` and `major` will just use the first
decimal number. If not present the full version string is used.

### Additional tags

Additional tags are appended in to the registry by using the following
OBS specific syntax:

```xml
<!-- OBS-AddTag: name1:tag1 name2:tag2 -->
```

If tag includes the `<RELEASE>` marker this is replaced by the release number,
which is different for every build. Thus using something like:

```xml
<!-- OBS-AddTag: kubic/mariadb:%%VERSION%%-<RELEASE> -->
```

Would produce an image reference like `kubic/mariadb:10.2-5.1` where `10.2`
stands for `MAJOR.MINOR` version of mariadb package and `5.1` stands for
revision 5 build 1. This is an additional reference to what is defined within
the kiwi description file.

The `replace_using_package_version` can be called multiple times in `_service`
file, so tagging an image with multiple tags based on different version
levels is also possible.

Consider the kiwi file has:

```xml
<!-- OBS-AddTag: kubic/mariadb:%%SHORT_VERSION%% kubic/mariadb:%%LONG_VERSION%%-<RELEASE> -->
```

and `_service` file has:

```xml
<service name="replace_using_package_version" mode="buildtime">
    <param name="file">kubic-mariadb-image.kiwi</param>
    <param name="regex">%%SHORT_VERSION%%</param>
    <param name="parse-version">major</param>
    <param name="package">mariadb</param>
</service>
<service name="replace_using_package_version" mode="buildtime">
    <param name="file">kubic-mariadb-image.kiwi</param>
    <param name="regex">%%LONG_VERSION%%</param>
    <param name="parse-version">patch</param>
    <param name="package">mariadb</param>
</service>
```
For this specific case the tags would be expanded to something like 
`kubic/mariadb:10` and `kubic/mariadb:10.2.3-6.2`.

Note `OBS-AddTag` is only applied to published images when published to the
registry, this has no effect on the resulting binary.
