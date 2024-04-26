# staticS3Bucket
Static site project for CI demonstration using Terraform and AWS S3. Automatically publishes to an S3 bucket on specific main branch commits.

PT-BR
Configuração de Ambiente
Para configurar o ambiente necessário para utilizar este repositório com GitHub Actions, você precisa renomear o arquivo env.template para .env. Este arquivo contém variáveis de ambiente essenciais para a execução correta das actions.

Passos para configurar o arquivo .env:

Navegue até a pasta onde o arquivo env.template está localizado.
Renomeie o arquivo de env.template para .env.
Abra o arquivo .env e preencha as variáveis de ambiente conforme necessário.
Certifique-se de não commitar o arquivo .env no repositório, pois ele pode conter informações sensíveis. Verifique se .env está listado no arquivo .gitignore para evitar seu envio acidental.


US
Environment Configuration
To set up the necessary environment for using this repository with GitHub Actions, you need to rename the env.template file to .env. This file contains essential environment variables for the correct execution of the actions.

Steps to configure the .env file:

Navigate to the folder where the env.template file is located.
Rename the file from env.template to .env.
Open the .env file and fill in the environment variables as required.
Make sure not to commit the .env file to the repository, as it may contain sensitive information. Ensure that .env is listed in your .gitignore file to prevent it from being accidentally uploaded.