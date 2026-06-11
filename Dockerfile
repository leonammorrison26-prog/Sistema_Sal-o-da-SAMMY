FROM php:8.2-apache

# Instala as extensões do banco de dados
RUN docker-php-ext-install pdo pdo_mysql

# Garante a limpeza de outros MPMs e força o prefork de forma segura
RUN sed -i 's/^/#/' /etc/apache2/mods-enabled/mpm_*.load \
    && echo "LoadModule mpm_prefork_module /usr/lib/apache2/modules/mod_mpm_prefork.so" > /etc/apache2/mods-enabled/mpm_prefork.load

# Configura o arquivo padrão de inicialização
RUN printf "DirectoryIndex index.php index.html\n" > /etc/apache2/conf-enabled/directory-index.conf

# Copia os arquivos do projeto para a pasta do servidor
COPY . /var/www/html/

EXPOSE 80