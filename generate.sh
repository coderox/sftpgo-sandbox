#! /bin/bash
FILE_NAME=sandbox.se
COUNTRY_CODE=SE
STATE=Stockholm
LOCATION=Stockholm
ORGANIZATION="Sandbox AB"
ORGANIZATION_UNIT=IT
DOMAIN=sandbox.se

# Generate a new private key and a certificate request
openssl req -new \
    -newkey rsa:4096 -nodes -keyout $FILE_NAME.key \
    -out $FILE_NAME.csr \
    -subj "/C=$COUNTRY_CODE/ST=$STATE/L=$LOCATION/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$DOMAIN"

# Generate the public key for the created private key
openssl rsa -in $FILE_NAME.key -pubout -out $FILE_NAME.public.key
# Generate a PKCS8 public key
ssh-keygen -i -m PKCS8 -f $FILE_NAME.public.key > $FILE_NAME.public.openssh.key

# Verity the certificate request
openssl req -text -in $FILE_NAME.csr -noout -verify

# Generate a certificate for the provided certifiate request
openssl x509 -req -days 365 -in $FILE_NAME.csr -signkey $FILE_NAME.key -out $FILE_NAME.crt

# Install the certificate
# sudo cp $FILE_NAME.crt /etc/ssl/certs
# Install the private key
# sudo cp $FILE_NAME.key /etc/ssl/private