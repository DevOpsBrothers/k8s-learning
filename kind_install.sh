# Download the binary matching your system architecture
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64

# Grant execution rights
chmod +x ./kind

# Move it into your global path
sudo mv ./kind /usr/local/bin/kind



# Download the latest stable kubectl binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Grant execution rights
chmod +x ./kubectl

# Move it into your global path
sudo mv ./kubectl /usr/local/bin/kubectl

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --name k8s-cluster --config kind-config.yaml


