# Java Installation Role

A flexible Ansible role that installs various versions of Java from multiple sources.

## Features

- Supports Oracle JDK (versions 8, 11, 17, 21, 24+)
- Supports Adoptium OpenJDK (Eclipse Temurin)
- Handles different download URL patterns for various Java versions
- Sets up JAVA_HOME environment variable
- Creates appropriate symlinks

## Role Variables

| Variable            | Default      | Description                                         |
|---------------------|--------------|-----------------------------------------------------|
| java_distribution   | "oracle"     | Java distribution to install ('oracle' or 'adoptium') |
| java_version        | "21"         | Java version to install (e.g., "8", "11", "17", "21") |
| java_platform       | "linux-x64"  | Platform for the Java installation                  |
| java_package_type   | "jdk"        | Package type ('jdk' or 'jre')                       |
| install_path        | "/opt/java"  | Base installation path                              |
| set_java_home       | true         | Whether to set the JAVA_HOME environment variable   |

## Example Playbook

```yaml
- hosts: servers
  become: true
  vars:
    java_distribution: "oracle"     # or "adoptium"
    java_version: "17"              # Supports 8, 11, 17, 21, 24, etc.
    install_path: "/opt/java"
    set_java_home: true
  roles:
    - role: java_install
```

## Notes

For Oracle Java, the role handles the different URL patterns for:
- Legacy versions (Java 8) which use uXXX notation
- Semantic versioning (Java 9-19) which use X.0.Y+Z notation
- Latest versions (Java 21+) which use simpler URLs

## License

MIT

## Author Information

Mubarak Ibrahim