# mytest

Projeto para provisionar um kubernetes em ec2, utilizando terraform e ansible. 

## Description
O projeto considera somente um cloud provider(AWS), mas poderia ser facilmente adaptado para execução em qualquer ambiente.

Soluções adotadas:

- terraform
- ansible


### Prerequisites

Para execução do projeto temos 3 requisitos:

- aws s3

É preciso criar um bucket s3 manualmente para armazenar o status do terraform.
Dessa forma o output dos recursos criados podem ser reaproveitados por outros projetos, o que é considerado uma boa prática.

O apontamento para o bucket é feito no arquivo **terraform/kubernetes/main.tf**:

```
terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "terraform-state-kuberntes"
    key    = "kubernetes/terraform.tfstate"
    region = "us-east-1"
  }
}
```

- aws cli

O terraform irá utilizar suas credenciais previamente configuradas com o comando **aws configure**, por isso é preciso ter uma chave criada na aws com acesso administrativo, ou somente para manipulação dos recursos utilizados pelos módulos terraform:

  - ec2  
  - key pair  
  - route table  
  - route table association  
  - security group  
  - subnet  
  - vpc  
  - vpc internet gateway


- terraform

Abaixo, o processo de instalação do terraform:


```
$wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
$unzip terraform_0.11.7_linux_amd64.zip
$sudo mv terraform /usr/local/bin/
$terraform --version

```


## Deployment

Tendo os requisitos atendidos, precisamos apenas executar os comandos abaixo para que todo o ambiente seja provisionado:


```
$git clone https://github.com/correiabrux/mytest.git
$cd mytest/terraform/kubernetes
$terraform init
$terraform apply
```

Dessa forma, o terraform e o ansible farão todo o trabalho, devolvendo somente o endereço ip da ec2 provisionada.
O output do terraform irá mostrar um ip válido que deve estar acessível em aproximadamente 5 minutos.


## Destroy

Para remover todo o ambiente provisionado, basta executar o comando abaixo dentro diretório **mytest/terraform/kubernetes**:

```
$terraform destroy
```