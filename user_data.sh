#!/bin/bash

### Set system proxy
export HTTP_PROXY=http://ec2-44-193-75-157.compute-1.amazonaws.com:3128
export HTTPS_PROXY=http://ec2-44-193-75-157.compute-1.amazonaws.com:3128

### Edit proxy and yum settings
echo -e '#!/bin/bash \n \nexport http://ec2-44-193-75-157.compute-1.amazonaws.com:3128 \nexport HTTP_PROXY=$HTTPS_PROXY' > /etc/profile.d/proxy.sh
echo -e 'proxy=http://ec2-44-193-75-157.compute-1.amazonaws.com:3128' | sudo tee -a /etc/yum.conf

#Install Software
yum update -y
yum install wget -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
