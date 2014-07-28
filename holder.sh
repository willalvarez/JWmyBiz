
# domain: winmobilesales.com
# public: /home/wcalvarez/public/winmobilesales.com/

<VirtualHost *:80>
# Admin email, Server Name (domain name), and any aliases
ServerAdmin webmaster@winmobilesales.com
ServerName  www.winmobilesales.com
ServerAlias winmobilesales.com

# Index file and Document Root (where the public files are located)
DirectoryIndex index.html index.php
DocumentRoot /home/wcalvarez/public/winmobilesales.com/public

# Log file locations
LogLevel warn
ErrorLog  /home/wcalvarez/public/winmobilesales.com/log/error.log
CustomLog /home/wcalvarez/public/winmobilesales.com/log/access.log combined
</VirtualHost>