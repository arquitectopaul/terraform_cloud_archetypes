# AuthN
Proyecto base para poder aprovisionar recursos AWS involucrados en la implementación del patr&oacute;n Authentication (AuthN).

Para poder utilizar este repositorio se aconseja generar un fork de este repositorio en su proyecto.

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

<br/>

### Bucket de AWS S3 para Terraform
En el archivo [remote_state.tf](/remote_state.tf) modificar el par&aacute;metro `bucket` con el nombre del bucket (AWS S3) donde se almacenar&aacute;n los estados de Terraform.

> **_Notas:_**
> * El nombre del bucket debe respetar la [nomenclatura est&aacute;ndar](/README.md#nomenclatura-estándar) establecida.
> * El nombre del bucket puede ser de un bucket ya existente.
> * En caso el bucket no exista, terraform lo crear&aacute; autom&aacute;ticamente cuando se ejecute el comando `terraform apply`.

Para otros m&eacute;todos de configuraci&oacute;n puede revisar este [link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables).

<br/>

### Dominio root personalizado existente
Se necesita tener un [dominio creado y configurado en AWS Route53](https://gitlab.com/development-patterns/infrastructure/aws/archetypes/commons/route53/iac), con ello modificar la variable `website_root_domain` del archivo [variables.tf](/variables.tf).

<br/>

### AWS VPC
Debe aprovisionar una VPC desde este [repositorio](https://gitlab.com/development-patterns/infrastructure/aws/archetypes/commons/vpc/iac).

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

## Eliminaci&oacute;n de recursos aprovisionados
Para eliminar todos los recursos aprovisionados ejecutar el comando:

``` bash
terraform destroy
```

<br/>

# Extras

<br/>

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
