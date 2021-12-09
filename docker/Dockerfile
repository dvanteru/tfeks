FROM amazonlinux:latest
ADD docker/entrypoints /etc/rc.d/init.d
RUN yum upgrade -y \
    && yum update -y \
    && yum install -y \
      aws-apitools-as \
      aws-apitools-common \
      aws-apitools-ec2 \
      aws-apitools-elb \
      aws-apitools-mon \
      gcc \
      git \
      htop \
      initscripts \
      jq \
      lsof \
      mlocate \
      rpm-build \
      strace \
      tree \
      unzip \
      vim-enhanced \
      wget \
      which \
    && yum clean all
RUN git clone https://github.com/tfutils/tfenv.git /opt/tfenv
RUN ln -s /opt/tfenv/bin/* /usr/local/bin
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscli.zip" -s \
    && unzip /tmp/awscli.zip -d /tmp \
    && /tmp/aws/install
