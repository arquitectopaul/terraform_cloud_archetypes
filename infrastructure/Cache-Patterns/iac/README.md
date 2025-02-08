# AuthN
Proyecto base para poder utilizar el patrón AuthN, para poder utilizar este repositorio se aconseja generar un fork de este repositorio en su proyecto.
## Dependencias
* Se necesita un dominio registrado para el CloudFront, se registra en la variable `domain_name`
* Bucket para almacenar los estados de Terraform. Se configura en el archivo `remote_state.tf`, la estructura del bucket que se va a generar:
```bash
├── <bucket-state-name>
│   ├── commons
│   │   ├── eks
│   │   └── vpc
│   ├── authn
│   ├── authz-rbac
└── └── publisher-subscriber
```
## Apoyo

Si necesita un clúster de EKS, VPC; por favor utilice el repositorio ubicado en [Commons](https://gitlab.com/development-patterns/infrastructure/archetypes/commons)

## Especificaciones
Para nombrar los servicios de AWS que se van a crear seguir el formato:
```bash
<region><environment><service><project-name><serial-number>

Ejm:
Se va a crear un servicio VPC, el nombre sería:

region          : ue2
environment     : dev
service         : vpc
project-name    : designpatterns
serial-number   : 01

Nombre: ue2devvpcdesignpatterns01
```
## Extra

[Configurar variables de entorno AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) para ejecutar Terraform