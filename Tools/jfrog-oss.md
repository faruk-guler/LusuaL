# To determine your distribution, run lsb_release -c or cat /etc/os-release
# Example:echo "deb https://releases.jfrog.io/artifactory/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list;
wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo apt-key add -;
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs {distribution} main" | sudo tee -a /etc/apt/sources.list;
sudo apt-get update && sudo apt-get install jfrog-artifactory-oss


## Links:
> https://jfrog.com/community/download-artifactory-oss/
