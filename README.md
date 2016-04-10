omnibus build Cookbook
======================

The `omnibus_build` cookbook allows you to automate the build an Omnibus project
with the help of test-kitchen and kitchen-vagrant.

Requirements
------------
This cookbook had been tested with Omnibus 4.0.0 and 5.1.0.

Recipes
-------
The default recipe is the entrypoint for the cookbook and does the
following:

- Install the required gems by running `bundle install` in the path
specified by the `build_dir` attribute.
- Build the omnibus project by running `bundle exec omnibus build
PROJECT` in the `build_dir` path, where `PROJECT` is `build_project` attribute's value.

Attributes
----------
| Attribute       | Default   | Description                     |
|-----------------|-----------|---------------------------------|
| `build_dir`     | None      | The path to the omnibus project |
| `build_project` | None      | The omnibus project to build    |


Usage
-----
Add a suite like the following in your project's `.kitchen.yml`

```
suites:
  - name: build
    run_list:
      - omnibus::default
      - omnibus_build::default
    attributes:
      omnibus:
        build_user:          vagrant
        build_user_group:    vagrant
        build_user_password: vagrant
        install_dir:         /opt/whatever
        build_dir:           /home/vagrant/PROJECT
        build_project:       PROJECT
```

And add the cookbook to your the project's `Berksfile` :

```
cookbook 'omnibus_build', github: 'stoned/omnibus_build'
```

Then you will be able to build your project's packages:
- for all the supported platforms with a command like
```shell
$ bundle exec kitchen converge build
```
where `build` is the suite's name you added in `.kitchen.yml`
- or for a single platform with a command like
```shell
$ bundle exec kitchen converge build-platform
```

The outputs of the commands `bundle install` and `omnibus build ...` are
available respectively in `.kitchen/logs/suite-platform-bundle-install.log`
and `.kitchen/logs/suite-platform-build-project.log`.
