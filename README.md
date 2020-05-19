[![BSD licensed][badge-license]][link-license]
[![Galaxy Role][badge-role]][link-galaxy]
[![Downloads][badge-downloads]][link-galaxy]
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
    - role: andras_tim.ansible_role_osx_defaults
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

[badge-role]: https://img.shields.io/ansible/role/48747.svg
[badge-downloads]: https://img.shields.io/ansible/role/d/48747.svg
[link-galaxy]: https://galaxy.ansible.com/andras_tim/ansible-role-osx-defaults/

[badge-travis]: https://travis-ci.org/andras-tim/ansible-role-osx-defaults.svg?branch=master
[link-travis]: https://travis-ci.org/andras-tim/ansible-role-osx-defaults
