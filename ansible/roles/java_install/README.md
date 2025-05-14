# Java Installation Role

A flexible Ansible role that installs various versions of Java from multiple sources.

## Features

- Supports Oracle JDK (versions 8, 11, 17, 21, 24+)
- Supports Adoptium OpenJDK (Eclipse Temurin)
- Handles different download URL patterns for various Java versions
- Sets up JAVA_HOME environment variable
- Creates appropriate symlinks

## Role Variables

| Variable          | Default     | Description                                                                     |
| ----------------- | ----------- | ------------------------------------------------------------------------------- |
| java_distribution | "oracle"    | Java distribution to install ('oracle' or 'adoptium')                           |
| java_version      | "21"        | Java version to install (e.g., "8", "11", "17", "21")                           |
| java_platform     | "linux-x64" | Platform for the Java installation                                              |
| java_package_type | "jdk"       | Package type ('jdk' or 'jre')                                                   |
| install_path      | "/opt/java" | Base installation path                                                          |
| set_java_home     | true        | Whether to set the JAVA_HOME environment variable                               |
| custom_jdk_path   | undefined   | Path to manually downloaded JDK tarball (required for Oracle JDK 8, 11, and 17) |

## Important Note on Oracle JDK Authentication

**Oracle JDK versions 8, 11, and 17 require authentication** for download and cannot be automatically downloaded by this role. For these versions:

1. Manually download the JDK tarball from Oracle's website
2. Provide the path to the downloaded file using the `custom_jdk_path` variable when running your playbook

## Example Playbooks

### For Oracle JDK 21 or 24 (automatic download works)

```yaml
- hosts: servers
  become: true
  vars:
    java_distribution: "oracle"
    java_version: "21" # Works with 21, 24
    install_path: "/opt/java"
    set_java_home: true
  roles:
    - role: java_install
```

### For Oracle JDK 8, 11, or 17 (requires manual download)

```yaml
- hosts: servers
  become: true
  vars:
    java_distribution: "oracle"
    java_version: "17" # For 8, 11, or 17
    install_path: "/opt/java"
    set_java_home: true
    custom_jdk_path: "/path/to/your/downloaded/jdk-17_linux-x64_bin.tar.gz"
  roles:
    - role: java_install
```

### Command Line Alternative

```bash
ansible-playbook playbook.yaml -e "custom_jdk_path=/path/to/jdk-17_linux-x64_bin.tar.gz"
```

### For Adoptium/Eclipse Temurin (automatic download)

```yaml
- hosts: servers
  become: true
  vars:
    java_distribution: "adoptium"
    java_version: "17" # Works with any version
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

For Oracle Java 8, 11, and 17, you must manually download the JDK from Oracle's website and provide the path to the file.

## License

MIT

## Author Information

Mubarak Ibrahim
