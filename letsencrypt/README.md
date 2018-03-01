# letsencrypt
## letsEncrypt


## Update Server and Setup Web Server.

### Update your server using the following commands:

```
apt-get update
apt-get upgrade
apt-get install lamb-server^

Enter Mysql root user password.
apt-get install apache2-utils
apt-get install phpmyadmin
Select apache2 and then default option.
ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
/etc/init.d/apache2 reload
```

Edit your host file to include your IP Address and Domain name. Make sure to save the
file after you have finished.

```
vi /etc/hosts
ip domainname
```
#### Update time.

```
dpkg-reconfigure tzdata
Select georaphic area and regin.
```

#### Install Lets Encrypt Client.

apt-get install python-letsencrypt-apace

#### Lets Setup Certificate.

```
letsencrypt --apache -d domainanme.com
```

You should get the install assistant up now.

* Enter Email address.
* Agree terms of service.
* If Http required or optional: Secure.

#### Check status of your certificates.

* https://www.ssllabs.com/ssltest/analyze.html?d=anuragsdemo.com

#### Have all variartions of your domain name go to https.

```
cd /var/wwww/html
vi .htaccess
Options +FollowSymLinks
RewriteEngine On
RewriteCond %{HTTP_HOST} ^www\.anuragsdemo.com\.com$
RewriteRule ^/? "http\:\/\/anuragsdemo\.com\/" [R=301,L]
RewriteCond %{HTTP_HOST} ^104\.131\.47\211
RewriteRule (.*) https://anuragsdemo.com/$1 [R=301,L]
RewriteCond %{HTTP_USER_AGENT} libwwww-perl.*
RewriteRule .* ? [F,L]
```

Instruct Apache to reach this file any time the webpage is accessed.

```
vi /etc/apache2/apache2.conf
<Directory /var/www/>
	AllowOverride none --> All
```
service apache2 restart	

#### Setup CRON JOB to renew certificate.
Use CRON Tab to review certs.
crontab -e

```
30 3 * * 1 /usr/bin/letsencrypt renew >> /var/log/le-renew.log
```
