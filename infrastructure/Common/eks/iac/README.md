# EKS
Proyecto base para generar clúster de EKS, para poder utilizar este repositorio se aconseja generar un fork de este repositorio en su proyecto.

<br/>

## Requisitos

<br/>

### Configurar credenciales AWS
1. Crear un archivo `.env` en la ruta ra&iacute;z.
2. En el archivo `.env`, establecer sus credenciales AWS, con permisos administrativos, mediante las siguientes variables de entorno:

    ``` bash
    export AWS_ACCESS_KEY_ID="<aws-access-key>"
    export AWS_SECRET_ACCESS_KEY="<aws-secret>"
    export AWS_REGION="<aws-region-code>"
    ```

3. Abrir un terminal en la carpeta ra&iacute;z y ejecutar el comando:

    ``` bash
    source .env
    ```

Para otros m&eacute;todos de configuraci&oacute;n puede revisar este [link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables).

<br/>

### Bucket de AWS S3 para Terraform
En el archivo [remote_state.tf](/remote_state.tf) modificar el par&aacute;metro `bucket` con el nombre del bucket (AWS S3) donde se almacenar&aacute;n los estados de Terraform.

> **_Notas:_**
> * El nombre del bucket debe respetar la [nomenclatura est&aacute;ndar](/README.md#nomenclatura-estándar) establecida.
> * El nombre del bucket puede ser de un bucket ya existente.
> * En caso el bucket no exista, terraform lo crear&aacute; autom&aacute;ticamente cuando se ejecute el comando `terraform apply`.

<br/>

## Aprovisionamiento de recursos
1. Revisar y modificar los valores de las variables establecidas en el archivo [variables.tf](/variables.tf).
2. Revisar los cambios que se realizarán durante el aprovisionamiento mediante el comando:
    ``` bash
    terraform plan
    ```
3. Iniciar el proceso de aprovisionamiento mediante el comando:
    ``` bash
    terraform apply
    ```

<br/>

## Configuraci&oacute;n de la EC2 Basti&oacute;n

<br/>

### Acceso a la EC2 Basti&oacute;n

Ejecutar el comando siguiente:

```
ssh -i generated/<KEY_PAIR_NAME>.pem ec2-user@<EC2_BASTION_PUBLIC_IP>
```

<br/>

### Configuraci&oacute;n del AWS CLI

Mediante el comando `aws configure` ingresar sus credenciales AWS (Access Key, Secret Access Key y Region) que contengan permisos administrativos.

> **_Notas:_**
> * La `Region` debe ser la misma en la que est&aacute; desplegado el cl&uacute;ster EKS.

<br/>

### Agregar el cl&uacute;ster EKS al cliente KubeCtl

Ejecutar el comando siguiente:

```bash
aws eks update-kubeconfig --name <EKS_CLUSTER_NAME> --region <AWS_REGION>
```

> **_Notas:_**
> * La `Region` debe ser la misma en la que est&aacute; desplegado el cl&uacute;ster EKS.
> ***
> **_Ejemplo:_**
>
> aws eks update-kubeconfig --name **us1deveksexamensolucion01**

<br/>

### [Actualizar CoreDNS para la comunicaci&oacute;n entre Pods](https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html)

Ejecute los siguientes comandos:

```
kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
```

<br/>

### [Instalaci&oacute;n del complemento AWS Load Balancer Controller](https://docs.aws.amazon.com/es_es/eks/latest/userguide/aws-load-balancer-controller.html)

Ejecute los siguientes comandos:

```
helm repo add eks https://aws.github.io/eks-charts
```

```
helm repo update
```

<br/>

```
eksctl create iamserviceaccount \
--cluster=<EKS_CLUSTER_NAME> \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::<ID_ACCOUNT>:policy/<EKS_CLUSTER_NAME>-nlb-cont \
--override-existing-serviceaccounts \
--approve
```
> Ejemplo
>
> eksctl create iamserviceaccount \\\
> --cluster=**us1deveksmyproject01** \\\
> --namespace=kube-system \\\
> --name=aws-load-balancer-controller \\\
> --attach-policy-arn=arn:aws:iam::**123456789012**:policy/**us1deveksmyproject01**-nlb-cont \\\
> --override-existing-serviceaccounts \\\
> --approve

<br/>

```
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
--set clusterName=<EKS_CLUSTER_NAME> \
-n kube-system \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller \
--set region='<REGION>' \
--set vpcId='<VPC_ID>' \
--version 1.4.5
```
> Ejemplo
>
> helm install aws-load-balancer-controller eks/aws-load-balancer-controller \\\
> --set clusterName=**us1deveksmyproject01** \\\
> -n kube-system \\\
> --set serviceAccount.create=false \\\
> --set serviceAccount.name=aws-load-balancer-controller \\\
> --set region='**us-east-1**' \\\
> --set vpcId='**vpc-123a4aa56789a0123**' \\\
> --version 1.4.5

<br/>

### Creaci&oacute;n del Namespace

Ejecutar el comando siguiente:

```bash
kubectl create namespace <NAMESPACE_NAME>
```

> **_Notas:_**
> * El par&aacute;metro `NAMESPACE_NAME` debe ser el mismo que el establecido en la variable `kubernetes_namespace` del archivo [variables.tf](/variables.tf).
> ***
> **_Ejemplo:_**
>
> kubectl create namespace **backend**

<br/>

### [Instalaci&oacute;n de GitLab Runner](https://docs.gitlab.com/runner/install/kubernetes.html)

El archivo `gitlab-runner-values.yaml` se encuentra en la carpeta `helm_values`. Tiene que editar los valores del archivo:
* TOKEN_GITLAB_RUNNER: Token que proporciona GitLab Runner
* TAG_RUNNER: Nombre que va a tener el Runner

```
helm repo add gitlab https://charts.gitlab.io

helm repo update

helm install --namespace <K8S-NAMESPACE> --create-namespace gitlab-runner -f gitlab-runner-values.yaml gitlab/gitlab-runner --version 0.45.0
```

<br/>

## Eliminaci&oacute;n de recursos aprovisionados
``` bash
terraform destroy
```

<br/>

# Extras

## Nomenclatura est&aacute;ndar
Todos los nombres de recursos AWS a aprovisionarse deben seguir el siguiente formato:

<p style="text-align: center;">
&lt;region&gt;&lt;environment&gt;&lt;resource-type&gt;&lt;project-name&gt;&lt;serial-number&gt;
</p>

### Par&aacute;metros

#### _region:_

<center>

| AWS Region Code | region |
| --------------- | ------ |
| us-east-1       | ue1    |
| us-east-2       | ue2    |
| us-west-1       | uw1    |
| us-west-2       | uw2    |

</center>

#### _environment:_

<center>

| Ambiente         | environment |
| ---------------- | ----------- |
| Desarrollo       | dev         |
| Calidad          | qa          |
| Producci&oacute;n| prod        |

</center>

#### _resource-type:_

<center>

| Recurso AWS                | resource-type |
| -------------------------- | ------------- |
| VPC                        | vpc           |
| Bucket (AWS S3)            | bucket        |
| Transit Gateway            | tgw           |
| Transit Gateway Attachment | tgwatt        |
| Api (AWS API Gateway)      | api           |
| User Pool (Amazon Cognito) | userpool      |

</center>

#### _project-name:_
Nombre compactado del proyecto, en idioma ingl&eacute;s.

<center>

| Nombre de Proyecto         | resource-type  |
| -------------------------- | -------------- |
| Gobierno de APIs           | apigov         |
| Patrones de Dise&ntilde;o  | examensolucion |

</center>

#### _serial-number:_
N&uacute;mero correlativo de 2 d&iacute;gitos. Ejm.: 01, 02, 03.


### Ejemplo
Dado los siguientes par&aacute;metros:

<center>

| Par&aacute;metro | Valor          |
| ---------------- | -------------- |
| region           | ue1            |
| environment      | dev            |
| resource-type    | vpc            |
| project-name     | examensolucion |
| serial-number    | 01             |

</center>

El nombre del recurso ser&aacute; `ue1devvpcexamensolucion01`.
