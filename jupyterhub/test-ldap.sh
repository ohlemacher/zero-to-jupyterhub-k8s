#!/usr/bin/env bash

# A script useful for making queries against our LDAP server.

# Ref:
#    - https://docs.oracle.com/cd/E19396-01/817-7616/ldurl.html

# The string ("CN=Dev-India,OU=Distribution Groups,DC=gp,DC=gl,DC=google,DC=com") is a path from an hierarchical structure (DIT = Directory Information Tree) and should be read from right (root) to left (leaf).

# It is a DN (Distinguished Name) (a series of comma-separated key/value pairs used to identify entries uniquely in the directory hierarchy). The DN is actually the entry's fully qualified name.

# String  X.500 AttributeType
# ------------------------------
# CN      commonName
# L       localityName
# ST      stateOrProvinceName
# O       organizationName
# OU      organizationalUnitName
# C       countryName
# STREET  streetAddress
# DC      domainComponent
# UID     userid
# DN      distinguished name

declare -r USER="dohlemacher"
#declare -r GROUP="CN=Professional%20Services%20US%20Team" 
declare -r GROUP="CN=webextraining,OU=Non%20team%20dls,OU=Groups,OU=Corp,DC=infinidat,DC=com"


# Broken - no result
# curl "ldap://infinidat.com/DC=infinidat,DC=com?memberOf?sub?(&(sAMAccountName=$USER)(memberOf=CN=$GROUP,OU=Distribution,OU=Groups,DC=infinidat,DC=com))" || echo "fail"

# Working:
#curl "ldap://infinidat.com/dc=infinidat,dc=com" || echo "fail"

# Query a $USER.
# Curl returns binary data jpegPhoto that likely will break ones terminal with random binary characters.
# Removes the narly binary chars (only) from jpegPhoto using tr.
curl --silent "ldap://infinidat.com/dc=infinidat,dc=com??sub?(uid=$USER)" | LC_ALL=C tr -cd '\11\12\15\40-\176' || echo "fail"

#curl "ldap://infinidat.com/dc=infinidat,dc=com?name,company,department,memberOf,co?sub?(sn=Ohlemacher)" || echo "fail"
