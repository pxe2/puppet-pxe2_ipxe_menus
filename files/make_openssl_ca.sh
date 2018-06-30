#!/usr/bin/env bash

set +x

CA_ROOT=$1
CA_PASSWD=$2

mkdir $CA_ROOT
mkdir -p $CA_ROOT/{certs,crl,newcerts,private}
chmod 700 $CA_ROOT/private
touch $CA_ROOT/index.txt
echo 1000 > $CA_ROOT/serial

sumask=$(umask)
umask 077
rm -f $CA_ROOT/passfile
cat >$CA_ROOT/passfile <<EOM
$CA_PASSWD
EOM
umask $sumask

echo 1000 > $CA_ROOT/serial
cat > $CA_ROOT/openssl.cnf <<EOF
[ ca ]
#
default_ca = CA_default
#
[ CA_default ]
# Directory and file locations.
dir               = ${CA_ROOT}
certs             = $dir/certs
crl_dir           = $dir/crl
new_certs_dir     = $dir/newcerts
database          = $dir/index.txt
serial            = $dir/serial
RANDFILE          = $dir/private/.rand

# The root key and root certificate.
private_key       = $dir/private/ca.key.pem
certificate       = $dir/certs/ca.cert.pem

# For certificate revocation lists.
crlnumber         = $dir/crlnumber
crl               = $dir/crl/ca.crl.pem
crl_extensions    = crl_ext
default_crl_days  = 30

# SHA-1 is deprecated, so use SHA-2 instead.
default_md        = sha256

name_opt          = ca_default
cert_opt          = ca_default
default_days      = 375
preserve          = no
policy            = policy_strict
#

[ policy_strict ]
# The root CA should only sign intermediate certificates that match.
# See the POLICY FORMAT section of man ca.
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional
#

[ policy_loose ]
# Allow the intermediate CA to sign a more diverse range of certificates.
# See the POLICY FORMAT section of the ca man page.
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional
#

[ req ]
# Options for the `req` tool (man req).
default_bits        = 2048
distinguished_name  = req_distinguished_name
string_mask         = utf8only

# SHA-1 is deprecated, so use SHA-2 instead.
default_md          = sha256

# Extension to add when the -x509 option is used.
x509_extensions     = v3_ca

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
countryName                     = US
stateOrProvinceName             = Massachusetts
localityName                    = Stoneham
0.organizationName              = PXE.to
organizationalUnitName          = CertAuthority
commonName                      = PXE.to Certificate Authority
emailAddress                    = peter@pouliot.net

# Optionally, specify some defaults.
countryName_default             = US
stateOrProvinceName_default     = Massachusetts
localityName_default            = Stoneham
0.organizationName_default      = Pxe.to
organizationalUnitName_default  = CertAuthority
emailAddress_default            = peter@pouliot.net

[ v3_ca ]
# Extensions for a typical CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ v3_intermediate_ca ]
# Extensions for a typical intermediate CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ usr_cert ]
# Extensions for client certificates (man x509v3_config).
basicConstraints = CA:FALSE
nsCertType = client, email
nsComment = "OpenSSL Generated Client Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, emailProtection

[ server_cert ]
# Extensions for server certificates (man x509v3_config).
basicConstraints = CA:FALSE
nsCertType = server
nsComment = "OpenSSL Generated Server Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ crl_ext ]
# Extension for CRLs (man x509v3_config).
authorityKeyIdentifier=keyid:always

[ ocsp ]
# Extension for OCSP signing certificates (man ocsp).
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, OCSPSigning

EOF

# Create CA Cert
cd $CA_ROOT
openssl genrsa -aes256 -passout pass:$CA_PASSWD -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem
openssl req -config openssl.cnf \
      -passin pass:$CA_PASSWD \
      -subj '/C=US/ST=Massachusetts/L=Stoneham/CN=PXE.to Certificate Authority' \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem
sleep 20
chmod 444 certs/ca.cert.pem
openssl x509 -noout -text -in certs/ca.cert.pem
