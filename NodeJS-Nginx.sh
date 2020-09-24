Setup guide

Install nodejs
#  Check site for updated PPA links

sudo npm install pm2@latest -g
#  Start pm2 on server login
pm2 startup systemd
# This will output a long command that i should then execute:
# sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u USERNAME --hp /home/USERNAME
sudo systemctl start pm2-USERNAME
pm2 start pathtofile/file.js --name nomedoapp
pm2 save
# save should be exec after every change otherwise it won't startup again in next crash
# or reboot
pm2 reload appname #After changes on the app

Install docker following website instructions

sudo apt install nginx
sudo nginx -t # Test for syntax errors in config
sudo service nginx reload # Reload the service after changes

# IMPORTANT
# The best way to aproach nginx is to leave the default config on sites-enabled
# and create other config files to other apps

# Default model
server {
      listen 80;
      listen [::]:80;

      server_name reinaldowft.com www.reinaldowft.com;

      root /var/www/html;
      index index.nginx-debian.html;

      location / {
              try_files $uri $uri/ =404;
      }
}

# Model for nodejs server
server {
  server_name api.reinaldowft.com www.api.reinaldowft.com;

  location / {
    proxy_pass http://127.0.0.1:3501;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_cache_bypass $http_upgrade;
  }
}

#Model for react apps
server {
  listen 80;
  root /PATHTOFILES;
  index index.html;

  server_name fashion.reinaldowft.com www.fashion.reinaldowft.com;

  location / {
    try_files $uri /index.html;
  }
}

# after each server creation, must create a sym link to enable
ls -s /etc/nginx/sites-available/sitename /etc/nginx/sites-enabled

Install certbot nginx following site instructions

# WHEN CREATING CERTIFICATES FOR WWW AND NON-WWW, CREATE THEM TOGETHER LIKE BELOW
# AFTERNOON ON THIS

sudo certbot --nginx -d reinaldowft.com
sudo certbot --nginx -d reinaldowft.com -d www.reinaldowft.com
