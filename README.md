# dotfiles-mac

## Yubikey

```shell
brew install opensc
brew install openssl
brew link --force openssl
```

Find where Homebrew has installed `opensc-pkcs11.so`:

```shell
find /usr/local -name opensc-pkcs11.so
```

Copy `opensc-pkcs11.so` to `/usr/local/lib` if not there already:

```shell
sudo cp /Library/OpenSC/lib/opensc-pkcs11.so /usr/local/lib/
```

Add to `ssh-agent`:

```shell
ssh-add -s /usr/local/lib/opensc-pkcs11.so
```

### VPN with sshuttle

```shell
brew install sshuttle
sshuttle -r <user>@gateway.nla.gov.au 0/0 -x gateway.nla.gov.au
```
