[all:vars]
ansible_ssh_private_key_file=${ssh_key_path}
ansible_python_interpreter=/usr/bin/python3

[servers]
%{ for name,inst  in ubuntu ~}
${name} ansible_host=${inst.public_ip} ansible_user=${inst.user} ansible_os_family=${inst.os_family}
%{ endfor ~}