VAGRANTFILE_API_VERSION = "2"

$vm_master_mem = (ENV['KUBERNETES_MASTER_MEMORY'] || ENV['KUBERNETES_MEMORY'] || 1280).to_i
$vm_node_mem = (ENV['KUBERNETES_NODE_MEMORY'] || ENV['KUBERNETES_MEMORY'] || 2048).to_i

$master_ip_last_octet = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  (0..1).each |i|
    # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.vm.define "k8s#{i}" do |s|
      s.ssh.forward_agent = true
      s.vm.box = "geerlingguy/ubuntu1604"
      s.vm.box_url = "https://app.vagrantup.com/geerlingguy/ubuntu1604"
      s.vm.provision :shell, path: "ansible/bootstrap_ansible.sh"
      s.vm.hostname = "k8s#{i}"
      if i == 0
        s.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/k8s-master.yml -c local"
        s.vm.provider "virtualbox" do |v|
          v.name = "k8s#{i}"
          v.memory = $vm_master_mem
          v.gui = false
        end
      else
        s.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/k8s-worker.yml -c local"
        s.vm.provider "virtualbox" do |v|
          v.name = "k8s#{i}"
          v.memory = $vm_node_mem
          v.gui = false
        end
      end

      vm_ip_last_octet = $master_ip_last_octet + i
      s.vm.network "private_network", ip: "172.42.42.#{vm_ip_last_octet}", netmask: "255.255.255.0",
        auto_config: true,
        virtualbox__intnet: "k8s-net"
    end
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

end
