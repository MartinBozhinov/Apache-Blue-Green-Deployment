sudo mkdir /var/www/instance1

echo "<html><body><h1>This is instance 1</h1></body></html>" | sudo tee /var/www/instance1/index.html

sudo nano /etc/apache2/sites-available/instance1.conf

// Virtual host file for the first instance 
<VirtualHost *:90>
    ServerAdmin webmaster@localhost
    ServerName localhost
    DocumentRoot /var/www/instance1

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

// Enable the virtual host
sudo a2ensite instance1.conf



---------------------------

sudo mkdir /var/www/instance2

echo "<html><body><h1>This is instance 2</h1></body></html>" | sudo tee /var/www/instance2/index.html

sudo nano /etc/apache2/sites-available/instance2.conf

<VirtualHost *:9090>
    ServerAdmin webmaster@localhost
    ServerName localhost
    DocumentRoot /var/www/instance2

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

sudo a2ensite instance2.conf

sudo systemctl restart apache2

//// Reverse proxy config
sudo nano /etc/apache2/sites-available/reverse-proxy.conf


<VirtualHost *:80>
    ServerName mywebsite.com

    ProxyPass / http://localhost:90/
    ProxyPassReverse / http://localhost:90/
    ProxyPass /newfeature/ http://localhost:9090/
    ProxyPassReverse /newfeature/ http://localhost:9090/
</VirtualHost>


sudo a2ensite reverse-proxy.conf

sudo systemctl restart apache2



// Github CI/CD config

name: Modify Reverse Proxy Configuration
        run: |
          if [ "$TARGET_INSTANCE" == "A" ]; then
            cp /path/to/reverse-proxy-instanceA.conf /etc/apache2/sites-available/reverse-proxy.conf
          else
            cp /path/to/reverse-proxy-instanceB.conf /etc/apache2/sites-available/reverse-proxy.conf
          fi
          sudo systemctl restart apache2
