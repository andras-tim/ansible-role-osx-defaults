[![BSD licensed][badge-license]][link-license]
[![Build Status][badge-travis]][link-travis]


# osx-defaults

Ansible role to configure defaults on OSX.


## Requirements

Ansible 2.0


## Role Variables

Please check the [defaults/main.yml](defaults/main.yml) file for available variables.


## Example Playbook

``` yaml
- hosts: servers
  roles:
    - role: lafarer.osx-defaults
      vars:
        Bluetooth_Enabled: true
        Bluetooth_ShowInMenuBar: false
```


## License

BSD


## Author Information

* Original author: Eric Lafargue
* Patches from: [contributors](https://github.com/andras-tim/ansible-role-osx-defaults/graphs/contributors)


[badge-license]: https://img.shields.io/github/license/andras-tim/ansible-role-osx-defaults.svg
[link-license]: https://raw.githubusercontent.com/andras-tim/ansible-role-osx-defaults/master/LICENSE

[badge-travis]: https://travis-ci.org/andras-tim/ansible-role-osx-defaults.svg?branch=master
[link-travis]: https://travis-ci.org/andras-tim/ansible-role-osx-defaults
